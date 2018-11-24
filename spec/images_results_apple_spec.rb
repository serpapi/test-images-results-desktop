describe "SerpApi Desktop JSON" do

  describe "Images result for Apple" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=apple&tbm=isch&location=Dallas&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains News Results array" do
      expect(@json["images_results"]).to be_an(Array)
    end

    it "News Results array has more than 10 results" do
      expect(@json["images_results"].size).to eq(100)
    end

    # sample of result
    # "images_results": [
    # {
    #   "position": 1,
    #   "thumbnail": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMzLN9iUjPiaNdA8w7NtzSTuJI0UPbDFOQKh3IXF6buUYmkaNr",
    #   "original": "https://as-images.apple.com/is/image/AppleInc/aos/published/images/o/g/og/default/og-default?wid=1200&hei=630&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1525370171638",
    #   "title": "Buy Mac Accessories - Apple",
    #   "source": "apple.com"
    # },
    describe "has a first news results" do

      before :all do
        @first_result = @json["images_results"][0]
      end

      it "has to be first" do
        expect(@first_result["position"]).to be(1)
      end

      it "has a thumbnail" do
        expect(@first_result["thumbnail"]).to_not be_empty
      end

      it "has a original" do
        expect(@first_result["original"]).to_not be_empty
      end

      it "has a title" do
        expect(@first_result["title"]).to_not be_empty
      end

      it "has a source" do
        expect(@first_result["source"]).to_not be_empty
      end

    end
  end

end