# coding: utf-8
describe GeoTriangleExt::CircumCenter do

  describe "#set_coordinate" do
    before do
      @cc = GeoTriangleExt::CircumCenter.new
      @cc.set_coordinate(1, 2)
    end
    it {@cc.coordinates.should == [[1,2]]}
  end

  describe "#coordinates" do

    context "default" do
      it {GeoTriangleExt::CircumCenter.new.coordinates.should be_empty}
    end

    context "has only 3 coordinates" do
      before do
        @cc = GeoTriangleExt::CircumCenter.new
        @cc.set_coordinate(1, 2)
        @cc.set_coordinate(3, 4)
        @cc.set_coordinate(5, 6)
        @cc.set_coordinate(7, 8)
      end
      it {@cc.coordinates.size.should == 3}
      it {@cc.coordinates.should == [[1,2],[3,4],[5,6]]}
    end

  end

  describe "#valid_coordinates?" do

    context "coordinates size not enough" do
      before do
        @cc = GeoTriangleExt::CircumCenter.new
        @cc.set_coordinate(1, 2)
        @cc.set_coordinate(3, 4)
      end
      it {@cc.coordinates.size.should == 2}
      it {@cc.valid_coordinates?.should be_false}
    end

    context "invalid coordinate format" do
      before do
        @cc = GeoTriangleExt::CircumCenter.new
        @cc.set_coordinate(1, 2)
        @cc.set_coordinate(3, 4)
        @cc.coordinates << 5
      end
      it {@cc.coordinates.size.should == 3}
      it {@cc.valid_coordinates?.should be_false}
    end

    context "valid coordinates" do
      before do
        @cc = GeoTriangleExt::CircumCenter.new
        @cc.set_coordinate(1, 2)
        @cc.set_coordinate(3, 4)
        @cc.set_coordinate(5, 6)
        @cc.set_coordinate(7, 8)
      end
      it {@cc.coordinates.size.should == 3}
      it {@cc.valid_coordinates?.should be_true}
    end

  end

  describe ".create" do

    context "create object" do
      subject {GeoTriangleExt::CircumCenter.create([1,2], [3,4], [5,6])}
      it {should be_instance_of(GeoTriangleExt::CircumCenter)}
      its(:coordinates) {should == [[1,2],[3,4],[5,6]]}
    end

    context "take 3 coordinates if given over 3" do
      subject {GeoTriangleExt::CircumCenter.create([1,2], [3,4], [5,6],[7,8])}
      it {should be_instance_of(GeoTriangleExt::CircumCenter)}
      its(:coordinates) {should == [[1,2],[3,4],[5,6]]}
    end

  end

  describe "#functions" do

    context "3 functions from triangle coordinates" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[5,6])
      end
      it {@cc.functions.size.should == 3}
    end

    context "not created if not valid coordinates" do
      before do
        @cc = GeoTriangleExt::CircumCenter.new
        @cc.set_coordinate(1, 2)
        @cc.set_coordinate(3, 4)
      end
      it {@cc.functions.should be_empty}
    end

    context "2 functions if 2 coordinates x or y is same" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[5,4])
      end
      it {@cc.functions.size.should == 2}
    end

    context "1 functions if right triangle" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[0,0])
      end
      it {@cc.functions.size.should == 1}
    end

  end

  describe "#valid_functions?" do

    context "valid triangle coordinates" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[5,6])
      end
      it {@cc.functions.size.should == 3}
      it {@cc.valid_functions?.should be_true}
    end

    context "2 functions is valid" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[5,4])
      end
      it {@cc.functions.size.should == 2}
      it {@cc.valid_functions?.should be_true}
    end

    context "1 functions is not valid" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[0,0])
      end
      it {@cc.functions.size.should == 1}
      it {@cc.valid_functions?.should be_false}
    end

    context "3 coordinates on same line" do
      before do
        @cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[4,-4])
      end
      it {@cc.functions.size.should == 3}
      it {@cc.valid_functions?.should be_false}
    end

  end

  describe "#center" do

    context "triangle coordinates" do
      before do
        cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[5,6])
        @x, @y = cc.center
      end
      it {@x.round(5).to_f.should == 3.25}
      it {@y.round(5).to_f.should == 3.125}
    end

    context "2 coordinates x or y is same" do
      before do
        cc = GeoTriangleExt::CircumCenter.create([0,4],[2,0],[5,4])
        @x, @y = cc.center
      end
      it {@x.round(5).to_f.should == 2.5}
      it {@y.round(5).to_f.should == 2.75}
    end

  end

end

