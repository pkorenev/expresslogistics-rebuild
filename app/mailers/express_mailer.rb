class ExpressMailer < ApplicationMailer
  def contact_feedback(f)
    to = FormConfigs::ContactFeedback.first.try(&:emails) || FormConfigs::ContactFeedback.default_emails
    @resource = f
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/express",
        template_name: "contact_feedback",
        layout: false,
        to: to,
        subject: "New Contact feedback",
        from: "ExpressLogistics"
    )
  end
end
