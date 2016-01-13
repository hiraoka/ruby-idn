# -*- coding: utf-8 -*-
require 'spec_helper'

describe RubyIdn do
  describe "#ascii_name" do
    it "converts dowmcase if include upcase character in name" do
      ruby_idn = RubyIdn.new(name: "FOO.JP")
      expect( ruby_idn.ascii_name ).to eq("foo.jp")
    end

    it "normalize name" do
      ruby_idn = RubyIdn.new(name: "foo。ＪＰ")
      expect( ruby_idn.ascii_name ).to eq("foo.jp")
    end

    it "from unicode" do
      ruby_idn = RubyIdn.new(name: "ふー。ＪＰ")
      expect( ruby_idn.ascii_name ).to eq("xn--19j6o.jp")
    end

    it "from ascii" do
      ruby_idn = RubyIdn.new(name: "xn--19j6o.jp")
      expect( ruby_idn.ascii_name ).to eq("xn--19j6o.jp")
    end
  end

  describe "#unicode_name" do
    it "converts dowmcase if include upcase character in name" do
      ruby_idn = RubyIdn.new(name: "FOO.JP")
      expect( ruby_idn.unicode_name ).to eq("foo.jp")
    end

    it "normalize name" do
      ruby_idn = RubyIdn.new(name: "foo。ＪＰ")
      expect( ruby_idn.unicode_name ).to eq("foo.jp")
    end

    it "not converts if name format is unicode" do
      ruby_idn = RubyIdn.new(name: "ふー.jp")
      expect( ruby_idn.unicode_name ).to eq("ふー.jp")
    end

    it "converts to unicode from ascii" do
      ruby_idn = RubyIdn.new(name: "xn--19j6o.jp")
      expect( ruby_idn.unicode_name ).to eq("ふー.jp")
    end
  end

  describe "self" do
    describe "#to_ascii" do
      it "converts dowmcase if include upcase character in name" do
        expect( RubyIdn.to_ascii("FOO.JP") ).to eq("foo.jp")
      end

      it "normalize name" do
        expect( RubyIdn.to_ascii("foo。ＪＰ") ).to eq("foo.jp")
      end

      it "converts to unicode from unicode" do
        expect( RubyIdn.to_ascii("ふー。ＪＰ") ).to eq("xn--19j6o.jp")
      end

      it "not converts if name format is asscii" do
        expect( RubyIdn.to_ascii("xn--19j6o.jp") ).to eq("xn--19j6o.jp")
      end

      it "not raise error if argment is nil" do
        expect( RubyIdn.to_ascii(nil) ).to eq(nil)
      end

      it "not raise error if argment is empty string" do
        expect( RubyIdn.to_ascii("") ).to eq("")
      end

      it "raise IdnError if too long string" do
        expect{ RubyIdn.to_ascii('1' * 64 + '.com') }.to raise_error(IdnError)
      end
    end

    describe "#to_unicode" do
      it "converts dowmcase if include upcase character in name" do
        expect( RubyIdn.to_unicode("FOO.JP") ).to eq("foo.jp")
      end

      it "normalize name" do
        expect( RubyIdn.to_unicode("foo。ＪＰ") ).to eq("foo.jp")
      end

      it "not converts if name format is unicode" do
        expect( RubyIdn.to_unicode("ふー。ＪＰ") ).to eq("ふー.jp")
      end

      it "converts to unicode from ascii" do
        expect( RubyIdn.to_unicode("xn--19j6o.jp") ).to eq("ふー.jp")
      end

      it "not raise error if argment is nil" do
        expect( RubyIdn.to_unicode(nil) ).to eq(nil)
      end

      it "not raise error if argment is empty string" do
        expect( RubyIdn.to_unicode("") ).to eq("")
      end
    end

    describe "#to_stringprep" do
      it "nomalize name (stringprep)" do
        expect( RubyIdn.to_stringprep("ふー。ＪＰ") ).to eq("ふー。jp")
      end
    end

    describe "#to_nameprep" do
      it "nomalize name (stringprep)" do
        expect( RubyIdn.to_nameprep("ふー。ＪＰ") ).to eq("xn--19j6o.jp")
      end
    end

    describe "#delete_unnecessary_char_for_error" do
      it "raise UnknownIdnError" do
        expect(Open3).to receive(:capture3).and_return(["","unknown error",""])
        expect{ RubyIdn.to_ascii('1' * 64 + '.com') }.to raise_error(UnknownIdnError)
      end
    end
  end
end
