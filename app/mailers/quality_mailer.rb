class QualityMailer < ActionMailer::Base
  default :to=>"josh@2gen.net", 
  		  :from =>"josh@2gen.net"

  def qualityStatus_email(user)
  	@user = user
  	@url = "http://ecosynthetix.com/"
  	mail(:subject=>"quality response test")
  end
end

