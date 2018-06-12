class StudentMailer < ApplicationMailer
  default from: 'notifications@ninthvalley.com'

  def course_email(student, instructor, subscription, course)
    @subscription = subscription
    @student = student
    @instructor = instructor
    @course = course
    mail(to: @student.email, subject: 'You might like this course | Ninth Valley')
  end

  def post_email(student, instructor, subscription, post)
    @subscription = subscription
    @student = student
    @instructor = instructor
    @post = post
    mail(to: @student.email, subject: 'You might like this post | Ninth Valley')
  end

  def subscription_email(student, instructor, subscription)
    @student = student
    @instructor = instructor
    @subscription = subscription
    mail(to: @student.email, subject: 'You\'ve subscribed to a new instructor! | Ninth Valley')
  end

  def purchase_email(student, instructor, purchase)
    @student = student
    @instructor = instructor
    @purchase = purchase
    mail(to: @student.email, subject: 'You\'ve purchased a new course! | Ninth Valley')
  end

  def refund_email(student, instructor, purchase)
    @student = student
    @instructor = instructor
    @purchase = purchase
    mail(to: @student.email, subject: 'You\'ve successfully refunded a course! | Ninth Valley')
  end

  def message_email(student, instructor, message)
    @student = student
    @instructor = instructor
    @message = message
    mail(to: @student.email, subject: 'You\'ve got a new message! | Ninth Valley')
  end

end