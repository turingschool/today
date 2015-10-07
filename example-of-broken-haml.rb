require 'tilt'

def render(name, template, &block)
  Tilt.new(name) { template }.render(&block)
end

def template1(&block)
  render "template1.haml", <<-HAML, &block
1
= template2 do
  2
  = yield
  3
4
HAML
end

def template2(&block)
  render "template2.haml", <<-HAML, &block
5
= yield
6
HAML
end

# should be 1257634
p template1 { '7' }.delete("\n")
# => "12735064"
