require_relative '../app'

describe KeyframeGen do
  before :all do
    @test_object_001 = KeyframeGen.new(5, 100, 5)
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
end
