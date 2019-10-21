module UsersHelper

    def user_picture(user)
        if user.image
            image_tag user.image, alt:"No Picture Available"
        else
            image_tag "", alt:"Not Available", class:"missing"
        end
    end

    def link_full_name_to_show_page(user)
        link_to user.full_name, user_path(user)
    end
end