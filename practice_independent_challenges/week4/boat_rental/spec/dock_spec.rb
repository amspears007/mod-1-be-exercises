require './lib/dock'
require './lib/boat'
require './lib/renter'

RSpec.describe Dock do
  let(:dock) {Dock.new("The Rowing Dock", 3) }
  let(:kayak_1) {Boat.new(:kayak, 20)}
  let(:kayak_2) {Boat.new(:kayak, 20)}
  let(:sup_1)  {Boat.new(:standup_paddle_board, 15)}
  let(:patrick)  {Renter.new("Patrick Star", "4242424242424242")}
  let(:eugene)  {Renter.new("Eugene Crabs", "1313131313131313")}

  it 'exists and has a name and max rent time' do 
    expect(dock).to be_a(Dock)
    expect(dock.name).to eq("The Rowing Dock")
    expect(dock.max_rental_time).to eq(3)
  end

  it 'can rent out boats to renters' do
    dock.rent(kayak_1, patrick) 
    dock.rent(kayak_2, patrick) 
    dock.rent(sup_1, eugene)

    expected = {
      kayak_1 => patrick, 
      kayak_2 => patrick, 
      sup_1 => eugene
    }

    # expected = {
    #   expected[kayak_1] = patrick
    #   expected[kayak_2] = patrick
    #   expected[sup_1] = eugene
    # }
    expect(dock.rental_log).to eq(expected)
  end

  it 'can charge people for rentals' do
    dock.rent(kayak_1, patrick) 
    dock.rent(kayak_2, patrick) 
    dock.rent(sup_1, eugene)
    kayak_1.add_hour
    kayak_1.add_hour

    expect(dock.charge(kayak_1)).to be_a(Hash)

    expected = {
      :card_number => "4242424242424242",
      :amount => 40
    }

    expect(dock.charge(kayak_1)).to eq(expected)
    expect(dock.rental_cost(kayak_1)).to eq(40)
  end
end