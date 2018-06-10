class InstructorMailer < ApplicationMailer
  default from: 'notifications@ninthvalley.com'

  def comment_email(instructor, comment)
    @instructor = instructor
    @comment = comment
    mail(to: @instructor.email, subject: 'You\'ve got a new comment! | Ninth Valley')
  end

  def review_email(instructor, review)
    @instructor = instructor
    @review = review
    mail(to: @instructor.email, subject: 'You\'ve got a new review! | Ninth Valley')
  end

  def subscription_email(instructor, subscription)
    @instructor = instructor
    @subscription = subscription
    mail(to: @instructor.email, subject: 'You\'ve got a new subscriber! | Ninth Valley')
  end

  def purchase_email(instructor, purchase)
    @instructor = instructor
    @purchase = purchase
    mail(to: @instructor.email, subject: 'You\'ve got a new purchase! | Ninth Valley')
  end

  def refund_email(instructor, purchase)
    @instructor = instructor
    @purchase = purchase
    mail(to: @instructor.email, subject: 'Someone refunded your course | Ninth Valley')
  end

  def message_email(instructor, message)
    @instructor = instructor
    @message = message
    mail(to: @instructor.email, subject: 'You\'ve got a new message! | Ninth Valley')
  end

end