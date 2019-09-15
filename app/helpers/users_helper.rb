module UsersHelper

    def user_picture(user)
        if user.image
            image_url user.image, alt:"No Picture Available"
        else
            image_tag "", alt:"No Picture Available"
        end
    end
end