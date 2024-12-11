package like;

public class LikeDTO {
    private int postId;
    private String category;
    private String userId;
    
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
}