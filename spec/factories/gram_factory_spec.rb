require 'spec_helper'
require 'pry'

describe GramFactory do

  let(:response) { SampleInstagramResponses.instagram_response }
  let (:test_grams) { [
        Gram.new(
      	text: "#love #TagsForLikes @TagsForLikes #instagood #me #smile #follow #cute #photooftheday #tbt #followme #tagsforlikes #girl #beautiful #happy #picoftheday #instadaily #food #swag #amazing #TFLers #fashion #igers #fun #summer #instalike #bestoftheday #smile #like4like #friends #instamood",
        screen_name: "oksanasovas",
        created_at: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//photos-f.ak.instagram.com/hphotos-ak-xaf1/10597252_804558659575749_663313685_a.jpg",
      	media_url: "http=>//scontent-a.cdninstagram.com/hphotos-xaf1/t51.2885-15/10665585_696868960405101_932172165_n.jpg"
      ),
      Gram.new(
      	text: "#elevator #kiss #love #budapest #basilica #tired",
        screen_name: "pollywoah",
        created_at: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//images.ak.instagram.com/profiles/profile_33110152_75sq_1380185157.jpg",
      	media_url: "http=>//scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/10684067_323739034474097_279647979_n.jpg"
      ),
      Gram.new(
      	text: "#wadmh3b #hbkl \nMnemani istri siang n mlm di hospital..\nDoakan supaya selamat melahirkan cahaya mata sulung utk kami...\n#Love #family #healthybaby #cute #sweet",
        screen_name: "cainmoxc",
        created_at: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//images.ak.instagram.com/profiles/profile_1090108603_75sq_1392225178.jpg",
        media_url: "http=>//scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10707046_1472778066326633_1828683552_n.jpg"
      ),
      Gram.new(
      	text: "[ t o d a y ] \n#me #noi #iger #Italia #italian #love #myboyfriend #tatoo #tatoowhitlove #ops #opslove #sempreassieme #tiamo #aspasso #september #tempodelcavolo #chedobbiamofà",
        screen_name: "jolanda_cirigliano",
        created_at: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http=>//photos-h.ak.instagram.com/hphotos-ak-xfa1/10448944_676691075735007_832582745_a.jpg",
      	media_url: "http=>//scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10691617_1510929602485903_1047906060_n.jpg"
      ) ]}

  it 'should make grams from instagram response' do
    
    factory_grams = GramFactory.make_grams(response)

    expect(Gram.all).to eq(test_grams)
    expect(Gram.all.reverse).to_not eq(test_grams)
  end

  it 'should not add grams with pics that are already in the db' do

    GramFactory.make_grams(response)
    GramFactory.make_grams(response)

    expect(Gram.all).to eq(test_grams)
    expect(Gram.all.reverse).to_not eq(test_grams)
  end


  it "should not add grams with censored words in the caption" do 
    response = SampleInstagramResponses.instagram_response_with_censored_words
    GramFactory.make_grams(response)
    expect(Gram.all).to be_empty
  end
end