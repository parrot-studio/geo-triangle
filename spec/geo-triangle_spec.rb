# coding: utf-8
describe GeoTriangle do

  describe "#exist?" do

    before do
      @gt = GeoTriangle.new
    end

    context "lat or lon is nil" do
      it {@gt.exist?(40.2, nil).should be_false}
      it {@gt.exist?(nil, 135.0).should be_false}
    end

    context "over value" do
      it {@gt.exist?(90.1, 135.0).should be_false}
      it {@gt.exist?(42.0, 180.1).should be_false}
    end

    context "valid lat and lon" do
      it {@gt.exist?(36.383304, 139.073632).should be_true}
    end

  end

  describe "#set_coordinate" do

    before do
      @gt = GeoTriangle.new
    end

    context "exist coordinate" do
      before do
        @gt.set_coordinate([36.383304, 139.073632])
        @gt.set_coordinate(36.391026, 139.075107)
      end
      it {@gt.coordinates.should == [[36.383304, 139.073632], [36.391026, 139.075107]]}
    end

    context "not exist coordinate" do
      before do
        @gt.set_coordinate([136.383304, 139.073632])
        @gt.set_coordinate(36.391026, 239.075107)
      end
      it {@gt.coordinates.should be_empty}
    end

    context "not coordinate pair" do
      before do
        @gt.set_coordinate(36.383304)
      end
      it {@gt.coordinates.should be_empty}
    end

  end

  describe "#valid_coordinates?" do

    before do
      @gt = GeoTriangle.new
    end

    context "coordinates size not enough" do
      before do
        @gt.set_coordinate([36.383304, 139.073632])
        @gt.set_coordinate(36.391026, 139.075107)
      end
      it {@gt.coordinates.size.should == 2}
      it {@gt.valid_coordinates?.should be_false}
    end

    context "invalid coordinate format" do
      before do
        @gt.set_coordinate([36.383304, 139.073632])
        @gt.set_coordinate(36.391026, 139.075107)
        @gt.coordinates << [135.0]
      end
      it {@gt.coordinates.size.should == 3}
      it {@gt.valid_coordinates?.should be_false}
    end

    context "valid coordinates" do
      before do
        @gt.set_coordinate([36.383304,139.073632])
        @gt.set_coordinate([36.391026,139.075107])
        @gt.set_coordinate([36.378536,139.046445])
        @gt.set_coordinate([37.378536,138.046445])
      end
      it {@gt.coordinates.size.should == 3}
      it {@gt.valid_coordinates?.should be_true}
    end

  end

  describe "#center" do

    before do
      @gt = GeoTriangle.new
    end

    context "valid coordinates center" do
      before do
        @gt.set_coordinate([36.383304,139.073632])
        @gt.set_coordinate([36.391026,139.075107])
        @gt.set_coordinate([36.378536,139.046445])
      end
      it {@gt.center.should == [36.384289, 139.065061]}
    end

    context "invalid coordinates" do
      before do
        @gt.set_coordinate([36.383304,139.073632])
        @gt.set_coordinate([36.391026,139.075107])
        @gt.set_coordinate([36.391026,139.075107])
      end
      it {@gt.coordinates.size.should == 2}
      it {@gt.valid_coordinates?.should be_false}
      it {@gt.center.should be_nil}
    end

  end

  describe ".center" do
    subject {GeoTriangle.center(
      [36.383304,139.073632], [36.391026,139.075107], [36.378536,139.046445])}
    it {should == [36.384289, 139.065061]}
  end

end

