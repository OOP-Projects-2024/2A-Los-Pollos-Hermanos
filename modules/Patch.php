<?php
class Patch{

    protected $pdo;

    public function __construct(\PDO $pdo){
        $this -> pdo = $pdo;
    }

    public function PatchUsers($body, $user_id) {
        $values = [];
        $errmsg = "";
        $code = 0;
    
        if (empty($user_id)) {
            $errmsg = "User ID is required.";
            $code = 400; 
            return array("error" => $errmsg, "code" => $code);
        }

        try {
            $sqlString = "SELECT * FROM users WHERE user_id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute([$user_id]);
            $user = $sql->fetch();
    
            if (!$user) {
                $errmsg = "User with ID $user_id not found.";
                $code = 404; 
                return array("error" => $errmsg, "code" => $code);
            }
    
        } catch (\PDOException $e) {
            error_log("PDOException in PatchUsers (user check): " . $e->getMessage());
            $errmsg = "An error occurred while checking the user. Please try again later.";
            $code = 500; 
            return array("error" => $errmsg, "code" => $code);
        }
    
        try {
            if (isset($body->password)) {
                $body->password = $this->encryptPassword($body->password);
            }

            $fields = [];
            foreach ($body as $key => $value) {
                $fields[] = "$key=?";
                $values[] = $value;
            }

            $values[] = $user_id;

            $sqlString = "UPDATE users SET " . implode(", ", $fields) . " WHERE user_id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute($values);

            $code = 200;
            $data = null;
            return array("data" => $data, "code" => $code);
    
        } catch (\PDOException $e) {
            error_log("PDOException in PatchUsers (update): " . $e->getMessage());
            $errmsg = "An error occurred while updating the user. Please try again later.";
            $code = 400; 
            return array("error" => $errmsg, "code" => $code);
            
        } catch (\Exception $e) {
            error_log("Exception in PatchUsers (update): " . $e->getMessage());
            $errmsg = "An unexpected error occurred. Please contact support.";
            $code = 400; 
            return array("error" => $errmsg, "code" => $code);
        }
    }
    
    
    private function encryptPassword($password) {
        $hashFormat = "$2y$10$";
        $saltLength = 22;
        $salt = $this->generateSalt($saltLength);
        return crypt($password, $hashFormat . $salt);
    }
    
    private function generateSalt($length) {
        $urs = md5(mt_rand(), true);
        $b64String = base64_encode($urs);
        $mb64String = str_replace("+", ".", $b64String);
        return substr($mb64String, 0, $length);
    }
    

    public function PatchPosts($body, $post_id){
        $values = [];
        $errmsg = "";
        $code = 0;
    
        if (empty($post_id)) {
            $errmsg = "Post ID is missing.";
            $code = 400; 
            return array("errmsg"=>$errmsg, "code"=>$code); 
        }

        try {
            $checkSql = "SELECT COUNT(*) FROM post WHERE post_id = ?";
            $checkStmt = $this->pdo->prepare($checkSql);
            $checkStmt->execute([$post_id]);
            $postExists = $checkStmt->fetchColumn();
    
            if (!$postExists) {
                $errmsg = "Post with ID $post_id does not exist.";
                $code = 404; 
                return array("errmsg"=>$errmsg, "code"=>$code); 
            }
        } catch (\PDOException $e) {
            $errmsg = "Error checking post existence: " . $e->getMessage();
            $code = 500; 
            return array("errmsg"=>$errmsg, "code"=>$code); 
        }

        foreach ($body as $value) {
            array_push($values, $value);
        }
        array_push($values, $post_id);
    
        try {
            $sqlString = "UPDATE post SET title=?, content=? WHERE post_id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute($values);
    
            $code = 200;
            $data = null;
    
            return array("data"=>$data, "code"=>$code); 
        } catch (\PDOException $e) {
            $errmsg = $e->getMessage();
            $code = 400; 
        }
    
        return array("errmsg"=>$errmsg, "code"=>$code); 
        
        return array("errmsg"=>$errmsg, "code"=>$code); 
    }

    public function archivePosts($id) {
        $code = 0;
        $payload = null;
        $remarks = "";
        $message = "";

        try {
            $headers = getallheaders();
            $username = $headers['X-Auth-User'];

            $sqlCheckUser = "SELECT role FROM users WHERE username=? AND (role = 1)";
            $stmtUser = $this->pdo->prepare($sqlCheckUser);
            $stmtUser->execute([$username]);

            if ($stmtUser->rowCount() == 0) {
                $code = 403;
                $remarks = "failed";
                $message = "Unauthorized. Admin or moderator access required.";
                return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
            }

            $sqlCheckPost = "SELECT post_id FROM post WHERE post_id=? AND isdeleted IS NULL";
            $stmtPost = $this->pdo->prepare($sqlCheckPost);
            $stmtPost->execute([$id]);

            if ($stmtPost->rowCount() == 0) {
                $code = 404;
                $remarks = "failed";
                $message = "Post not found or already deleted.";
                return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
            }

            $sqlDelete = "UPDATE post SET isdeleted = 1 WHERE post_id=?";
            $stmtDelete = $this->pdo->prepare($sqlDelete);
            $stmtDelete->execute([$id]);

            $code = 200;
            $remarks = "success";
            $message = "Archived successfully.";
            $payload = array("archived_user_id" => $id);

        } catch (\PDOException $e) {
            $code = 400;
            $remarks = "failed";
            $message = $e->getMessage();
        }

        return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
    }

    public function archiveComment($comment_id) {
        $code = 0;
        $payload = null;
        $remarks = "";
        $message = "";
    
        try {
            $headers = getallheaders();
            $username = $headers['X-Auth-User'];

            $sqlCheckUser = "SELECT role FROM users WHERE username=? AND role IN (1)";
            $stmtUser = $this->pdo->prepare($sqlCheckUser);
            $stmtUser->execute([$username]);
    
            if ($stmtUser->rowCount() == 0) {
                $code = 403;
                $remarks = "failed";
                $message = "Unauthorized. Admin or moderator access required.";
                return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
            }

            $sqlCheckComment = "SELECT comment_id FROM comment WHERE comment_id=? AND isdeleted IS NULL";
            $stmtComment = $this->pdo->prepare($sqlCheckComment);
            $stmtComment->execute([$comment_id]);
    
            if ($stmtComment->rowCount() == 0) {
                $code = 404;
                $remarks = "failed";
                $message = "Comment not found or already archived.";
                return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
            }

            $sqlArchive = "UPDATE comment SET isdeleted = 1 WHERE comment_id=?";
            $stmtArchive = $this->pdo->prepare($sqlArchive);
            $stmtArchive->execute([$comment_id]);
    
            $code = 200;
            $remarks = "success";
            $message = "Comment archived successfully.";
            $payload = array("archived_comment_id" => $comment_id);
    
        } catch (\PDOException $e) {
            $code = 500;
            $remarks = "failed";
            $message = "An error occurred while archiving the comment.";
            error_log($e->getMessage());
        }
    
        return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
    }
    

    public function PatchComment($body, $comment_id){
        $values = [];
        $errmsg = "";
        $code = 0;

        if (empty($comment_id)) {
            $errmsg = "Comment ID is missing.";
            $code = 400; 
            return array("errmsg"=>$errmsg, "code"=>$code); 
        }

        try {
            $checkSql = "SELECT COUNT(*) FROM comment WHERE comment_id = ?";
            $checkStmt = $this->pdo->prepare($checkSql);
            $checkStmt->execute([$comment_id]);
            $commentExists = $checkStmt->fetchColumn();
    
            if (!$commentExists) {
                $errmsg = "Comment with ID $comment_id does not exist.";
                $code = 404; 
                return array("errmsg"=>$errmsg, "code"=>$code); 
            }
        } catch (\PDOException $e) {
            $errmsg = "Error checking comment existence: " . $e->getMessage();
            $code = 500; 
            return array("errmsg"=>$errmsg, "code"=>$code); 
        }

        foreach ($body as $value) {
            array_push($values, $value);
        }
        array_push($values, $comment_id);
    
        try {
            $sqlString = "UPDATE comment SET content=? WHERE comment_id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute($values);
    
            $code = 200;
            $data = null;
    
            return array("data"=>$data, "code"=>$code); 
        } catch (\PDOException $e) {
            $errmsg = $e->getMessage();
            $code = 400; 
        }
    
        return array("errmsg"=>$errmsg, "code"=>$code); 
    }
    

    public function updateRole($body) {
        $code = 0;
        $payload = null;
        $remarks = "";
        $message = "";
    
        try {
            $adminHeaders = getallheaders();
            $adminUsername = $adminHeaders['X-Auth-User'];

            $sqlCheckAdmin = "SELECT role FROM users WHERE username=?";
            $stmtAdmin = $this->pdo->prepare($sqlCheckAdmin);
            $stmtAdmin->execute([$adminUsername]);
    
            if ($stmtAdmin->rowCount() > 0) {
                $adminResult = $stmtAdmin->fetch();
                if ($adminResult['role'] < 1) { 
                    $code = 403;
                    $remarks = "Failed";
                    $message = "Unauthorized. Admin access required.";
                    return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
                }
            } else {
                $code = 403;
                $remarks = "Failed";
                $message = "Admin username not found.";
                return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
            }

            $sqlCheckUser = "SELECT username FROM users WHERE username=?";
            $stmtUser = $this->pdo->prepare($sqlCheckUser);
            $stmtUser->execute([$body->username]);
    
            if ($stmtUser->rowCount() == 0) { 
                $code = 401;
                $remarks = "Failed";
                $message = "Username does not exist.";
                return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
            }

            $sqlString = "UPDATE users SET role=? WHERE username=?";
            $stmtUpdate = $this->pdo->prepare($sqlString);
            $stmtUpdate->execute([$body->role, $body->username]);
    
            $code = 200;
            $remarks = "Success";
            $message = "User promoted successfully.";
            $payload = array("username" => $body->username, "new_role" => $body->role);
    
        } catch (\PDOException $e) {
            $code = 400;
            $remarks = "failed";
            $message = $e->getMessage();
        }
    
        return array("payload" => $payload, "remarks" => $remarks, "message" => $message, "code" => $code);
    }
}

?>