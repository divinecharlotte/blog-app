module Response
    extend ActiveSupport::Concern
  
    def json_response(object, status = :ok)
      render json: object, status:
    end
  end