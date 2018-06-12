class InstructorMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/email/welcome
  def comment_email
    InstructorMailer.comment_email(Instructor.first, Comment.first)
  end

  def review_email
    InstructorMailer.review_email(Instructor.first, Review.first)
  end

  def purchase_email
    InstructorMailer.purchase_email(Instructor.first, Purchase.first)
  end

  def refund_email
    InstructorMailer.refund_email(Instructor.first, Purchase.first)
  end

  def subscription_email
    InstructorMailer.subscription_email(Instructor.first, Subscription.first)
  end

end