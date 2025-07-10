package model;

public class SubjectCategoryDTO {
    private String subjectName;
    private int courseCount;
    private int order;

    // Getters and Setters
    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    public int getCourseCount() {
        return courseCount;
    }
    public void setCourseCount(int courseCount) {
        this.courseCount = courseCount;
    }
    public int getOrder() {
        return order;
    }
    public void setOrder(int order) {
        this.order = order;
    }
}