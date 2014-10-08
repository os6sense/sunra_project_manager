describe RecordingFormat do
  describe :initialise do
    before (:each) do
	    @rf = RecordingFormat.new
    end
    it "will not create an empty format" do
      @rf.save
    end
  end
end
