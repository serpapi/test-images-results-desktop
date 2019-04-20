describe "Images resutls - desktop - json" do

  before(:all) do
     @host = 'https://serpapi.com'
     if ENV['SERPAPI_MODE'] == 'dev'
        puts "use local development server"
        @host = 'http://localhost:3000'
     end
  end

  describe "Images results for apple and ijn = 0" do

    before :all do
      @response = HTTP.get @host + '/search.json?q=Coffee&location=Austin%2C+Texas%2C+United+States&hl=en&gl=us&output=json&tbm=isch&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "images_results is an array" do
      expect(@json["images_results"]).to be_an(Array)
    end

    it "images Results array has more than 10 results" do
      expect(@json["images_results"].size).to be > 50
    end

    # sample of result
    # "images_results": [
    # {
    #   "position": 1,
    #   "thumbnail": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMzLN9iUjPiaNdA8w7NtzSTuJI0UPbDFOQKh3IXF6buUYmkaNr",
    #   "original": "https://as-images.apple.com/is/image/AppleInc/aos/published/images/o/g/og/default/og-default?wid=1200&hei=630&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1525370171638",
    #   "title": "Buy Mac Accessories - Apple",
    #   "source": "apple.com",
    #   "link": "apple.com/",
    # },
    describe "has a first images results" do

      before :all do
        @first_result = @json["images_results"][0]
      end

      it "has to be first" do
        expect(@first_result["position"]).to eq(1)
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

      it "has a link" do
        expect(@first_result["link"]).to_not be_empty
      end
      
    end

    describe "verify chips at the top of the page" do

      it "check thumbnail present for the first 10 chips" do
        @json["suggested_searches"].each_with_index do |chip, index|
          # only the first 10 chips images are visible
          next if index > 10
          
          # bug in google
          next if chip['name'] =~ /tea/

          expect(chip['thumbnail']).to_not be_empty, "thumbnail empty at index: #{index}, name: #{chip['name']}"
        end
      end

      it "number of chips greater than 5" do
        expect(@json["suggested_searches"].size).to be > 5
      end

      it 'verify the first chip field' do
        chip  = @json["suggested_searches"].first
        expect(chip['name']).to_not be_empty
        expect(chip['chips']).to_not be_empty
        expect(chip['serpapi_link']).to match(/search.json\?/)
        expect(chip['link']).to match(/\/search\?/)
        expect(chip['thumbnail']).to_not be_empty
        expect(chip['thumbnail']).to match(/^data:image\/jpeg;base64/)
      end

      it 'verify the last chip field - no thumbnail' do
        chip  = @json["suggested_searches"].last
        expect(chip['name']).to_not be_empty
        expect(chip['chips']).to_not be_empty
        expect(chip['serpapi_link']).to match(/search.json\?/)
        expect(chip['link']).to match(/\/search\?/)
        expect(chip['thumbnail']).to be_nil
      end

    end
  end

  describe "Images results for apple and ijn = 1" do

    before :all do
      @response = HTTP.get @host + '/search.json?q=Coffee&location=Austin%2C+Texas%2C+United+States&hl=en&gl=us&output=json&tbm=isch&ijn=1&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains images Results array" do
      expect(@json["images_results"]).to be_an(Array)
    end

    it "images Results array has more than 10 results" do
      expect(@json["images_results"].size).to be > 50
    end

    describe "has a first images results" do

      before :all do
        @first_result = @json["images_results"][0]
      end

      it "has to be first" do
        expect(@first_result["position"]).to eq(101)
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

      it "has a link" do
        expect(@first_result["link"]).to_not be_empty
      end
      
    end

    describe "has a last images results" do
      before :all do
        @last_result = @json["images_results"].last
      end

      it "has to be first" do
        expect(@last_result["position"]).to eq(200)
      end

      it "has a thumbnail" do
        expect(@last_result["thumbnail"]).to_not be_empty
      end

      it "has a original" do
        expect(@last_result["original"]).to_not be_empty
      end

      it "has a title" do
        expect(@last_result["title"]).to_not be_empty
      end

      it "has a source" do
        expect(@last_result["source"]).to_not be_empty
      end

      it "has a link" do
        expect(@last_result["link"]).to_not be_empty
      end
    end

    it "no chips if ijn == 1" do
      expect(@json["suggested_searches"]).to be_empty
    end

  end

  describe "Images results for apple and ijn = 2" do

    before :all do
      @response = HTTP.get @host + '/search.json?q=Coffee&location=Austin%2C+Texas%2C+United+States&hl=en&gl=us&output=json&tbm=isch&ijn=2&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to eq(200)
    end

    it "object array" do
      expect(@json["images_results"]).to be_an(Array)
    end

    it "check number of elements in the array - google does not provide all 100 images after the 2 requests" do
      expect(@json["images_results"].size).to be > 10
    end

    describe "has a first images results" do

      before :all do
        @first_result = @json["images_results"][0]
      end

      it "has to be first" do
        expect(@first_result["position"]).to eq(201)
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

      it "has a link" do
        expect(@first_result["link"]).to_not be_empty
      end
   end

    describe "has a last images results" do
      before :all do
        @last_result = @json["images_results"].last
      end

      it "has to be first" do
        expect(@last_result["position"]).to be > 200
      end

      it "has a thumbnail" do
        expect(@last_result["thumbnail"]).to_not be_empty
      end

      it "has a original" do
        expect(@last_result["original"]).to_not be_empty
      end

      it "has a title" do
        expect(@last_result["title"]).to_not be_empty
      end

      it "has a source" do
        expect(@last_result["source"]).to_not be_empty
      end

      it "has a link" do
        expect(@last_result["link"]).to_not be_empty
      end
    end

    it "no chips if ijn == 2" do
      expect(@json["suggested_searches"]).to be_empty
     end

  end

  describe "Images results for apple with tbs=itp:photos,isz:l and ijn=0" do

    before :all do
      @response = HTTP.get @host + '/search.json?q=apple&tbm=isch&ijn=0&tbs=itp:photos,isz:l&location=Dallas&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to eq(200)
    end

    it "object array" do
      expect(@json["images_results"]).to be_an(Array)
    end

    it "100 elements in the array" do
      expect(@json["images_results"].size).to eq(100)
    end

    describe "has a first results" do

      before :all do
        @first_result = @json["images_results"].first
      end

      it "has to be first" do
        expect(@first_result["position"]).to eq(1)
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

      it "has a link" do
        expect(@first_result["link"]).to_not be_empty
      end
   end
  end

end
