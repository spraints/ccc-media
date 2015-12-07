class SermonsController
  def show
    @sermon = Sermon.for_date(params)
  end
end
