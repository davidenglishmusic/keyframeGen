require_relative '../app'

describe KeyframeGen do
  before :all do
    @test_object_001 = KeyframeGen.new(5, 100, 5)
    @test_object_002 = KeyframeGen.new(7, 70, 10)
    @test_object_003 = KeyframeGen.new(9, 70, 9)
    @test_object_004 = KeyframeGen.new(2, 50, 3)
  end

  describe 'generate_frame' do
    it 'returns a integer' do
      expect(@test_object_001.generate_frame.class).to eq(Fixnum)
    end
  end

  describe 'unique?' do
    it 'returns true if the keyframe does not exist, the frame is at least a proximity variable amount away from zero, and is a proximity variable amount less than the total number of frames' do
      expect(@test_object_001.unique?(6, [30, 90])).to eq(true)
    end
    it 'returns false if the keyframe exists' do
      expect(@test_object_001.unique?(6, [6, 90])).to eq(false)
    end
    it 'returns false if the keyframe is within the proximity variable amount to zero' do
      expect(@test_object_001.unique?(5, [30, 90])).to eq(false)
    end
    it 'returns false if the keyframe is within the proximity variable amount to the total number of frames' do
      expect(@test_object_001.unique?(95, [30, 90])).to eq(false)
    end
  end

  describe 'too_close?' do
    it 'returns false if there are no keyframes yet' do
      expect(@test_object_001.too_close?(6, [])).to eq(false)
    end
    it 'returns true if the new keyframes is within the proximity variable amount to another keyframe' do
      expect(@test_object_001.too_close?(6, [11])).to eq(true)
    end
    it 'returns true if the new keyframes is within the proximity variable amount to another keyframe' do
      expect(@test_object_001.too_close?(16, [11])).to eq(true)
    end
    it 'returns false if the keyframes is within an acceptable distance from other keyframes' do
      expect(@test_object_001.too_close?(50, [11, 46, 90])).to eq(true)
    end
  end

  describe 'possible_to_calculate?' do
    it 'returns true if it is possible to generate the number of keyframes within the specified clip length with the proximity requirement' do
      expect(@test_object_002.possible_to_calculate?).to eq(true)
    end
    it 'returns true if it is possible to generate the number of keyframes within the specified clip length with the proximity requirement' do
      expect(@test_object_003.possible_to_calculate?).to eq(true)
    end
  end

  describe 'easy_to_calculate?' do
    it 'returns true if the number of keyframes to generate is significantly lower than the the clip length divided by the proximity requirement' do
      expect(@test_object_002.easy_to_calculate?).to eq(false)
    end
    it 'returns true if the number of keyframes to generate is significantly lower than the the clip length divided by the proximity requirement' do
      expect(@test_object_004.easy_to_calculate?).to eq(true)
    end
  end
end
