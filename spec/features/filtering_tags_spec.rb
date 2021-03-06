feature "filtering tags" do
  scenario "filter links by tag" do
    create_link_with_tag('search_engine')
    create_link_with_tag('bubbles')
    visit "/tags/bubbles"
    expect(page).to have_content 'Tags:bubbles'
    expect(page).not_to have_content 'Tags:seach_engine'
  end
end
