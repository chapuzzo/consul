include DocumentParser
class LocalCensus

  def call(document_type, document_number)
    Response.new(get_record(document_type, document_number))
  end

  class Response
    def initialize(body)
      @body = body
    end

    def valid?
      @body.present? ? !@body.attributes.values.include?("" || nil) : false
    end

    def date_of_birth
      @body.date_of_birth
    end

    def postal_code
      @body.postal_code
    end

    def district_code
        @body.district_code
    rescue
        nil
    end

    def gender
      case @body.gender
      when "Varón"
        "male"
      when "Mujer"
        "female"
      end
    rescue NoMethodError
      nil
    end

    def name
        "#{@body.nombre} #{@body.apellido1}"
    rescue
        nil
    end

    private

      def data
        @body.attributes
      end
  end

  private

    def get_record(document_type, document_number)
      LocalCensusRecord.find_by(document_type: document_type, document_number: document_number)
    end

    def dni?(document_type)
      document_type.to_s == "1"
    end

end
