describe '#method00' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("[\"hello\",\"world!\"]")
    expect(uut.method00(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
  end
end
