<?php
include_once "Common.php";
class Get extends Common{

    protected $pdo;

    public function __construct(\PDO $pdo){
        $this -> pdo = $pdo;
    }

    public function getLogs($date = "2024-12-07") {
        $filename = "./logs/$date" . ".log";
        $logs = array();
        
        try {
            $file = new SplFileObject($filename);
            while (!$file->eof()) {
                array_push($logs, $file->fgets());
            }
            $remarks = "success";
            $message = "Successfully retrieved logs";
        } 
        catch (Exception $e) {
            $remarks = "failed";
            $message = $e->getMessage();
        }

        return $this->generateResponse(array("logs"=>$logs), $remarks, $message, 200);        
    }
  
    public function getPosts($post_id = null){
        $condition = "isdeleted is NULL";
        if($post_id != null){
            $condition .= " AND post_id=" . $post_id;
        }

        $result = $this->getDataByTable('post', $condition, $this->pdo);

        if($result['code'] == 200){
            if ($post_id !== null) {
                // Use the PATCH logic (incrementViewCount) here
                $patchResult = $this->incrementViewCount($post_id);
    
                if ($patchResult['code'] !== 200) {
                    // If increment fails, append error but still return the fetched data
                    return $this->generateResponse(
                        $result['data'], 
                        "partial_success", 
                        "Successfully retrieved records, but view count update failed: " . $patchResult['errmsg'], 
                        206
                    );
                }
            }   
    
            return $this->generateResponse(
                $result['data'], 
                "success", 
                "Successfully retrieved records.", 
                $result['code']
            );
        }

        return $this->generateResponse(null, "failed", $result['errmsg'], $result['code']);
    }

    private function incrementViewCount($post_id) {
        $sql = "UPDATE post SET views = views + 1 WHERE post_id = :post_id";
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->bindParam(':post_id', $post_id, \PDO::PARAM_INT);
            $stmt->execute();
            return array("code" => 200, "message" => "View count incremented successfully.");
        } catch (\PDOException $e) {
            return array("code" => 500, "errmsg" => $e->getMessage());
        }
    }

    public function getData() {
        $sql = "SELECT 
                    post.post_id,
                    post.title, 
                    post.views, 
                    post.category_category_id, 
                    post.image, 
                    post.content, 
                    post.created_at, 
                    comment.comment_username, 
                    comment.content AS comment_content, 
                    comment.created_at AS comment_created_at 
                FROM 
                    post 
                INNER JOIN 
                    comment 
                ON 
                    post.post_id = comment.post_post_id 
                WHERE 
                    post.isdeleted = 0 AND comment.isdeleted IS NULL";
    
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute();
            $data = $stmt->fetchAll(\PDO::FETCH_ASSOC);

            $uniquePostIds = [];
            foreach ($data as $row) {
                if (!in_array($row['post_id'], $uniquePostIds)) {
                    $this->incrementViewCount($row['post_id']);
                    $uniquePostIds[] = $row['post_id'];
                }
            }
    
            return $this->generateResponse($data, "Success", "Successfully retrieved Blogs.", 200);
        } catch (\PDOException $e) {
            return $this->generateResponse(null, "failed", $e->getMessage(), 500);
        }
    }

    public function getPostWithComments($post_id) {

        $this->incrementViewCount($post_id);

        $sql = "SELECT 
                    post.post_id, 
                    post.user_user_id, 
                    post.category_category_id, 
                    post.title, 
                    post.image, 
                    post.views,
                    post.content AS post_content, 
                    post.created_at AS post_created_at,
                    comment.comment_id, 
                    comment.content AS comment_content, 
                    comment.created_at AS comment_created_at
                FROM 
                    post
                LEFT JOIN 
                    comment 
                ON 
                    post.post_id = comment.post_post_id
                WHERE 
                    post.post_id = :post_id AND 
                    post.isdeleted = 0 AND 
                    (comment.isdeleted = 0 OR comment.isdeleted is NULL)";
    
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->bindValue(':post_id', $post_id, \PDO::PARAM_INT);
            $stmt->execute();
            $data = $stmt->fetchAll(\PDO::FETCH_ASSOC);
    
            if (!$data) {
                return $this->generateResponse(null, "Failed", "No post found with the specified post_id.", 404);
            }
    
            return $this->generateResponse($data, "Success", "Successfully retrieved post and comments.", 200);
        } catch (\PDOException $e) {
            return $this->generateResponse(null, "Failed", $e->getMessage(), 500);
        }
    }
    


}

?>