# encoding: utf-8
# frozen_string_literal: true

require_relative '../../test_helper'
require 'pagy/extras/semantic'

describe Pagy::Frontend do

  let(:frontend) { TestView.new }
  let(:pagy_test_id) { 'test-id' }

  describe "#pagy_semantic_nav" do

    it 'renders first page' do
      pagy = Pagy.new(count: 1000, page: 1)
      frontend.pagy_semantic_nav(pagy).must_equal \
        "<div class=\"pagy-semantic-nav ui pagination menu\" aria-label=\"pager\"><div class=\"item disabled\"><i class=\"left small chevron icon\"></i></div><a class=\"item active\">1</a><a href=\"/foo?page=2\"  class=\"item\" rel=\"next\" >2</a><a href=\"/foo?page=3\"  class=\"item\" >3</a><a href=\"/foo?page=4\"  class=\"item\" >4</a><a href=\"/foo?page=5\"  class=\"item\" >5</a><div class=\"disabled item\">...</div><a href=\"/foo?page=50\"  class=\"item\" >50</a><a href=\"/foo?page=2\"  class=\"item\" rel=\"next\" aria-label=\"next\"><i class=\"right small chevron icon\"></i></a></div>"
    end

    it 'renders intermediate page' do
      pagy = Pagy.new(count: 1000, page: 20)
      frontend.pagy_semantic_nav(pagy).must_equal \
        "<div class=\"pagy-semantic-nav ui pagination menu\" aria-label=\"pager\"><a href=\"/foo?page=19\"  class=\"item\" rel=\"prev\" aria-label=\"previous\"><i class=\"left small chevron icon\"></i></a><a href=\"/foo?page=1\"  class=\"item\" >1</a><div class=\"disabled item\">...</div><a href=\"/foo?page=16\"  class=\"item\" >16</a><a href=\"/foo?page=17\"  class=\"item\" >17</a><a href=\"/foo?page=18\"  class=\"item\" >18</a><a href=\"/foo?page=19\"  class=\"item\" rel=\"prev\" >19</a><a class=\"item active\">20</a><a href=\"/foo?page=21\"  class=\"item\" rel=\"next\" >21</a><a href=\"/foo?page=22\"  class=\"item\" >22</a><a href=\"/foo?page=23\"  class=\"item\" >23</a><a href=\"/foo?page=24\"  class=\"item\" >24</a><div class=\"disabled item\">...</div><a href=\"/foo?page=50\"  class=\"item\" >50</a><a href=\"/foo?page=21\"  class=\"item\" rel=\"next\" aria-label=\"next\"><i class=\"right small chevron icon\"></i></a></div>"
    end

    it 'renders last page' do
      pagy = Pagy.new(count: 1000, page: 50)
      frontend.pagy_semantic_nav(pagy).must_equal \
        "<div class=\"pagy-semantic-nav ui pagination menu\" aria-label=\"pager\"><a href=\"/foo?page=49\"  class=\"item\" rel=\"prev\" aria-label=\"previous\"><i class=\"left small chevron icon\"></i></a><a href=\"/foo?page=1\"  class=\"item\" >1</a><div class=\"disabled item\">...</div><a href=\"/foo?page=46\"  class=\"item\" >46</a><a href=\"/foo?page=47\"  class=\"item\" >47</a><a href=\"/foo?page=48\"  class=\"item\" >48</a><a href=\"/foo?page=49\"  class=\"item\" rel=\"prev\" >49</a><a class=\"item active\">50</a><div class=\"item disabled\"><i class=\"right small chevron icon\"></i></div></div>"
    end

  end

  describe "#pagy_semantic_nav_js" do

    it 'renders first page' do
      pagy = Pagy.new(count: 1000, page: 1)
      html = frontend.pagy_semantic_nav_js(pagy, pagy_test_id)
      html.must_equal \
      "<div id=\"test-id\" class=\"pagy-semantic-nav-js ui pagination menu\" role=\"navigation\" aria-label=\"pager\"></div><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<div class=\\\"item disabled\\\"><i class=\\\"left small chevron icon\\\"></i></div>\",\"link\":\"<a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"  class=\\\"item\\\" >#{Pagy::Frontend::MARKER}</a>\",\"active\":\"<a class=\\\"item active\\\">1</a>\",\"gap\":\"<div class=\\\"disabled item\\\">&hellip;</div>\",\"after\":\"<a href=\\\"/foo?page=2\\\"  class=\\\"item\\\" rel=\\\"next\\\" aria-label=\\\"next\\\"><i class=\\\"right small chevron icon\\\"></i></a>\"},{\"0\":[\"1\",2,3,4,5,\"gap\",50]}]</script>"
    end

    it 'renders intermediate page' do
      pagy = Pagy.new(count: 1000, page: 20)
      html = frontend.pagy_semantic_nav_js(pagy, pagy_test_id)
      html.must_equal \
      "<div id=\"test-id\" class=\"pagy-semantic-nav-js ui pagination menu\" role=\"navigation\" aria-label=\"pager\"></div><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a href=\\\"/foo?page=19\\\"  class=\\\"item\\\" rel=\\\"prev\\\" aria-label=\\\"previous\\\"><i class=\\\"left small chevron icon\\\"></i></a>\",\"link\":\"<a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"  class=\\\"item\\\" >#{Pagy::Frontend::MARKER}</a>\",\"active\":\"<a class=\\\"item active\\\">20</a>\",\"gap\":\"<div class=\\\"disabled item\\\">&hellip;</div>\",\"after\":\"<a href=\\\"/foo?page=21\\\"  class=\\\"item\\\" rel=\\\"next\\\" aria-label=\\\"next\\\"><i class=\\\"right small chevron icon\\\"></i></a>\"},{\"0\":[1,\"gap\",16,17,18,19,\"20\",21,22,23,24,\"gap\",50]}]</script>"
    end

    it 'renders last page' do
      pagy = Pagy.new(count: 1000, page: 50)
      html = frontend.pagy_semantic_nav_js(pagy, pagy_test_id)
      html.must_equal \
      "<div id=\"test-id\" class=\"pagy-semantic-nav-js ui pagination menu\" role=\"navigation\" aria-label=\"pager\"></div><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a href=\\\"/foo?page=49\\\"  class=\\\"item\\\" rel=\\\"prev\\\" aria-label=\\\"previous\\\"><i class=\\\"left small chevron icon\\\"></i></a>\",\"link\":\"<a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"  class=\\\"item\\\" >#{Pagy::Frontend::MARKER}</a>\",\"active\":\"<a class=\\\"item active\\\">50</a>\",\"gap\":\"<div class=\\\"disabled item\\\">&hellip;</div>\",\"after\":\"<div class=\\\"item disabled\\\"><i class=\\\"right small chevron icon\\\"></i></div>\"},{\"0\":[1,\"gap\",46,47,48,49,\"50\"]}]</script>"
    end

    it 'renders with :steps' do
      pagy = Pagy.new(count: 1000, page: 20, steps: {0 => [1,2,2,1], 500 => [2,3,3,2]})
      html = frontend.pagy_semantic_nav_js(pagy, pagy_test_id)
      html.must_equal \
      "<div id=\"test-id\" class=\"pagy-semantic-nav-js ui pagination menu\" role=\"navigation\" aria-label=\"pager\"></div><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a href=\\\"/foo?page=19\\\"  class=\\\"item\\\" rel=\\\"prev\\\" aria-label=\\\"previous\\\"><i class=\\\"left small chevron icon\\\"></i></a>\",\"link\":\"<a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"  class=\\\"item\\\" >#{Pagy::Frontend::MARKER}</a>\",\"active\":\"<a class=\\\"item active\\\">20</a>\",\"gap\":\"<div class=\\\"disabled item\\\">&hellip;</div>\",\"after\":\"<a href=\\\"/foo?page=21\\\"  class=\\\"item\\\" rel=\\\"next\\\" aria-label=\\\"next\\\"><i class=\\\"right small chevron icon\\\"></i></a>\"},{\"0\":[1,\"gap\",18,19,\"20\",21,22,\"gap\",50],\"500\":[1,2,\"gap\",17,18,19,\"20\",21,22,23,\"gap\",49,50]}]</script>"
    end

  end

  describe "#pagy_semantic_combo_nav_js" do

    it 'renders first page' do
      pagy = Pagy.new(count: 103, page: 1)
      html = frontend.pagy_semantic_combo_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<div id=\"test-id\" class=\"pagy-semantic-combo-nav-js ui compact menu\" role=\"navigation\" aria-label=\"pager\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"  class=\"item\" style=\"display: none;\" rel=\"nofollow\"></a><div class=\"item disabled\"><i class=\"left small chevron icon\"></i></div><div class=\"pagy-combo-input item\">Page <input type=\"number\" min=\"1\" max=\"6\" value=\"1\" style=\"padding: 0; text-align: center; width: 2rem; margin: 0 0.3rem\"> of 6</div> <a href=\"/foo?page=2\"  class=\"item\" rel=\"next\" aria-label=\"next\"><i class=\"right small chevron icon\"></i></a></div><script type=\"application/json\" class=\"pagy-json\">[\"combo_nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",1,false]</script>"
    end

    it 'renders intermediate page' do
      pagy = Pagy.new(count: 103, page: 3)
      html = frontend.pagy_semantic_combo_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<div id=\"test-id\" class=\"pagy-semantic-combo-nav-js ui compact menu\" role=\"navigation\" aria-label=\"pager\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"  class=\"item\" style=\"display: none;\" rel=\"nofollow\"></a><a href=\"/foo?page=2\"  class=\"item\" rel=\"prev\" aria-label=\"previous\"><i class=\"left small chevron icon\"></i></a><div class=\"pagy-combo-input item\">Page <input type=\"number\" min=\"1\" max=\"6\" value=\"3\" style=\"padding: 0; text-align: center; width: 2rem; margin: 0 0.3rem\"> of 6</div> <a href=\"/foo?page=4\"  class=\"item\" rel=\"next\" aria-label=\"next\"><i class=\"right small chevron icon\"></i></a></div><script type=\"application/json\" class=\"pagy-json\">[\"combo_nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",3,false]</script>"
    end

    it 'renders last page' do
      pagy = Pagy.new(count: 103, page: 6)
      html = frontend.pagy_semantic_combo_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<div id=\"test-id\" class=\"pagy-semantic-combo-nav-js ui compact menu\" role=\"navigation\" aria-label=\"pager\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"  class=\"item\" style=\"display: none;\" rel=\"nofollow\"></a><a href=\"/foo?page=5\"  class=\"item\" rel=\"prev\" aria-label=\"previous\"><i class=\"left small chevron icon\"></i></a><div class=\"pagy-combo-input item\">Page <input type=\"number\" min=\"1\" max=\"6\" value=\"6\" style=\"padding: 0; text-align: center; width: 2rem; margin: 0 0.3rem\"> of 6</div> <div class=\"item disabled\"><i class=\"right small chevron icon\"></i></div></div><script type=\"application/json\" class=\"pagy-json\">[\"combo_nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",6,false]</script>"
    end

  end


end
