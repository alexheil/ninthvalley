class StudentMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/email/welcome
  def course_email
    StudentMailer.course_email(Student.first, Instructor.first, Subscription.first, Course.first)
  end

  def post_email
    StudentMailer.post_email(Student.first, Instructor.first, Subscription.first, Post.first)
  end

  def purchase_email
    StudentMailer.purchase_email(Student.first, Instructor.first, Purchase.first)
  end

  def refund_email
    StudentMailer.refund_email(Student.first, Instructor.first, Purchase.first)
  end

  def subscription_email
    StudentMailer.subscription_email(Student.first, Instructor.first, Subscription.first)
  end

end