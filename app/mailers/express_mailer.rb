class ExpressMailer < ApplicationMailer
  def contact_feedback(f)
    to = FormConfigs::ContactFeedback.first.try(&:emails) || FormConfigs::ContactFeedback.default_emails
    @resource = f
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/express",
        template_name: "contact_feedback",
        to: to,
        subject: "New Contact feedback from expresslogistics.com.ua",
        from: "ExpressLogistics"
    )
  end

  def order(f)
    to = FormConfigs::Order.first.try(&:emails) || FormConfigs::Order.default_emails
    @resource = f
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/express",
        template_name: "order",
        to: to,
        subject: "New Order from expresslogistics.com.ua",
        from: "ExpressLogistics"
    )
  end
end
