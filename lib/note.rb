class Note

  def initialize(params = {})
    @number = params.fetch(:note, 0)
    @score = nil
  end

  def valid?(note2, note3)
    exception_checks && normal_checks
  end

  private

  def exception_checks
  end

  def normal_checks
  end

end
