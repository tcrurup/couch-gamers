module UsersHelper

    def user_picture(user)
        if user.image
            image_tag user.image, alt:"No Picture Available"
        else
            image_tag "", alt:"Not Available", class:"missing"
        end
    end
end