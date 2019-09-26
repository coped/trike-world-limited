class StaticPagesController < ApplicationController
    def home
    end

    def about
    end

    def contact
    end

    def send_contact_message
        ContactMailer.contact_message(contact_params)
        flash[:success] = "Message successfully sent."
        redirect_to contact_url
    end

    private

        def contact_params
            params.require(:contact).permit(:email, :phone_number, :message)
        end
end
