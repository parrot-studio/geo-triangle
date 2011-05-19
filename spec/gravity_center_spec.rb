# coding: utf-8
describe GravityCenter do

  describe ".create" do

    context "3 coordinates set" do
      subject {GravityCenter.create([1,2],[3,4],[5,6])}
      it {should be_instance_of(GravityCenter)}
      its(:x1) {should == 1.0}
      its(:y1) {should == 2.0}
      its(:x2) {should == 3.0}
      its(:y2) {should == 4.0}
      its(:x3) {should == 5.0}
      its(:y3) {should == 6.0}
    end

    context "6 numbers set" do
      subject {GravityCenter.create(10,20,30,40,50,60)}
      it {should be_instance_of(GravityCenter)}
      its(:x1) {should == 10.0}
      its(:y1) {should == 20.0}
      its(:x2) {should == 30.0}
      its(:y2) {should == 40.0}
      its(:x3) {should == 50.0}
      its(:y3) {should == 60.0}
    end

  end

  describe "#sx1, #sx2, #sy1, #sy2 is shifted coordinates for (x3,y3) to (0,0)" do
    subject {GravityCenter.create([0,4],[2,0],[5,6])}
    its(:sx1) {should == -5.0}
    its(:sy1) {should == -2.0}
    its(:sx2) {should == -3.0}
    its(:sy2) {should == -6.0}
  end

  describe "#center_sx, #center_sy is gravity center of shifted triangle" do
    subject {GravityCenter.create([0,4],[2,0],[5,6])}
    it {subject.center_sx.round(6).to_f.should == -2.666667}
    it {subject.center_sy.round(6).to_f.should == -2.666667}
  end

  describe "#center_x, #center_y is gravity center of original triangle" do
    subject {GravityCenter.create([0,4],[2,0],[5,6])}
    it {subject.center_x.round(6).to_f.should == 2.333333}
    it {subject.center_y.round(6).to_f.should == 3.333333}
  end

  describe "#center is gravity center coordinate of triangle" do
    before do
      gc = GravityCenter.create([0,4],[2,0],[5,6])
      @x, @y = gc.center
    end
    it {@x.round(6).to_f.should == 2.333333}
    it {@y.round(6).to_f.should == 3.333333}
  end

end

