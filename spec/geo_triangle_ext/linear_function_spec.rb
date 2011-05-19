# coding: utf-8
describe GeoTriangleExt::LinearFunction do

  describe "#valid?" do

    context "ax == bx" do
      before do
        @lf = GeoTriangleExt::LinearFunction.new
        @lf.ax = 1
        @lf.ay = 2
        @lf.bx = 1
        @lf.by = 5
      end
      it {@lf.valid?.should be_false}
    end

    context "bx == by" do
      before do
        @lf = GeoTriangleExt::LinearFunction.new
        @lf.ax = 1
        @lf.ay = 2
        @lf.bx = 7
        @lf.by = 2
      end
      it {@lf.valid?.should be_false}
    end

    context "unrelated" do
      before do
        @lf = GeoTriangleExt::LinearFunction.new
        @lf.ax = 1
        @lf.ay = 2
        @lf.bx = 7
        @lf.by = 0
      end
      it {@lf.valid?.should be_true}
    end

  end

  describe ".create" do
    subject{GeoTriangleExt::LinearFunction.create(1, 2, 7, 0)}
    it {should be_instance_of(GeoTriangleExt::LinearFunction)}
    its(:ax) {should == 1.0}
    its(:ay) {should == 2.0}
    its(:bx) {should == 7.0}
    its(:by) {should == 0.0}
  end

  describe "#middle_point" do

    context "positive number only" do
      before do
        @lf = GeoTriangleExt::LinearFunction.create(1, 2, 7, 1)
      end
      it {@lf.middle_point.should == [4.0, 1.5]}
    end

    context "include negative number" do
      before do
        @lf = GeoTriangleExt::LinearFunction.create(1, 2, -7, -1)
      end
      it {@lf.middle_point.should == [-3.0, 0.5]}
    end

  end

  describe "#slope" do
    before do
      @lf = GeoTriangleExt::LinearFunction.create(0, 4, 2, 0)
    end
    it {@lf.slope.should == -2.0}
  end

  describe "#intercept" do
    before do
      @lf = GeoTriangleExt::LinearFunction.create(0, 4, 2, 0)
    end
    it {@lf.intercept.should == 4.0}
  end

  describe "#orthogonal_slope" do
    before do
      @lf = GeoTriangleExt::LinearFunction.create(0, 4, 2, 0)
    end
    it {@lf.orthogonal_slope.should == 0.5}
  end

  describe "#orthogonal_intercept" do
    before do
      @lf = GeoTriangleExt::LinearFunction.create(0, 4, 2, 0)
    end
    it {@lf.orthogonal_intercept.should == 1.5}
  end

end

