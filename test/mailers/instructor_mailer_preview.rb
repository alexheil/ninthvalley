class InstructorMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/email/welcome
  def comment_email
    InstructorMailer.comment_email(Instructor.first, Comment.first)
  end
end