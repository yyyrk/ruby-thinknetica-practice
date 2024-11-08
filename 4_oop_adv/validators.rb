module Validators

  def valid_number?(input)
    /^d{4}$/.match?(input)
  end

end