module ApplicationHelper
    def back_or_url(url = "/")
        redirect_back(fallback_location: url)
    end

    def model_date(model)
        model.updated_at > model.created_at ? 
        "#{model.created_at} ~ #{model.updated_at}" 
        : "#{model.created_at}"
    end
end
