class CensusCaller

  def call(document_type, document_number)
    response = LocalCensus.new.call(document_type, document_number)

    response
  end
end
