require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'activesupport', require: 'active_support/all'
end

require_relative 'doukaku'

MAX_WIDTH = 19
BOARD_SIZE = 400
PADDING = 30

data = %w(
  d3d4e3e4d9h7h9j3j4j7j9,f4f6g4g5g6h5h6
  a1,s19
  a1a2b1b2,r18r19s18s19
  b1d1b2d2e2f2b5d5e5f5b6d6,b3d3b4d4
  b2c2e2f2b3c3e3f3b5c5e5f5,d4
  a1a18s1s18,a19
  b11b15i11i15,a13h3m1q9
  b7b8b15f7f8q8,d1d14j16n14o19p7
  c3e9g17h4p17p19r12s13,c5c6d18k5k6k10n14p6
  b7c12c13i8j12j13k7k16l1r18,a15b18d18f16h5j6m10n6n7o8
  a12a17b10b17b19d7e12g3g17g19q18s2,c10c16f5g7i5j13k6l4n19o7p9q19
  a19b2b3d2e13f5f14g15h1i7o2p19q3r17,a4a6a8a18b17c4c8f13h8j8l13n12n17p5
  b13b14b17c4d12e3f16h5l19m2n1n19o3o4o14q13q16,d3d8d14e1e16f12g6j8o1p5p7q1r9r15r16s5s7
  b6b17c4c9c12c16d14e14g5g9i10j10j13m8q2q5q18r1r6,b8c11e13f3h11h18j7m1m3m7n3n4n11o4p12q3q4q17s13
  a9a10a15d2d16d17d18g18i11k11k15l14m15n5n11o1p6p14q11q14r7r15,a11c3c10c12d4f1f16f19g3g6g10i16k2k16l12n12o12p1r5r6s9s11
  a10c4c16c19e12g11g17h1h9i8i12i17i19k18l5l16n10n19p12p19q5q9r6r9r16,b8b19c1c10d11d15e1f3f8f13i7j5j8k1k6l2l4l6l11m2m13p2r1r11s18
  a12a19b6b7c13c19d5d12d19e8f7h1h14i3k4k5k15l10m3n3o2p18q11q17q19r11r14s18,c6c7c9e16f8f9f13g14h9h12h15j5j10j18k11k14k18n5n18o1o18p4p10p14r13s2s7s13
  a8b18d6e6f12f16g9g12h15i7j5j6j12k2k10k11k19l6n18o15p6q6r1r2r5r6r9r17s1s19,a10a13a15b6b10c1c5c18d18e1e3e5e19g3h6j7j15j17k18l3l9m2m4m14m16n9o17q18s7s13
  a3a15b17d1e4e19f1f10f13f15g8h3h6h11i6i12j18l5l8l9l11m3m8n7n8n18o3o19p13r7r17s2s11,a6c1c2c5c13d13e16f2f5f14g1g2g4g5g14i10j9k1k7k15m2m4n13n14n19p6p18q7q13r3r18s17s18
  a6a8a9b1b12d1d3d4f4f13f16g7h10j13j15j17k2k6k7k15k17l2l17m5m8n4n12n18o11o13p9q6r15s2s3s17,a2b7b14c2c8c19d8e1e3e15f5f14g9g14h15i11i18k16l10l11l18m9o2o3o5p10p17q2q5q19r1r6r18s1s7s19
  a2b1c1c5c12c14d12e2e17g4g7g19h3h9h18i2i8i14j3j15j17k13k19l8l15l16l18n8n12o14o15o18o19p17q6q9q12r3r5,a11a14a19b7c11e6e10e13e14e19f3f4f14h15h17i1j19k1k2k3k7k10l11l19m4m13n1n5n13n16o1o7o17p5q16r2r8r12s6
  a15a18b15b16b18c4c10c13c18d7d10e15g6g9g14i6i19j9j15k1k5k16k17l2l14l18m5m9n3n7n14o5o7o8p13p17q5q9r11r12r16s11,a6a10a12a19b6c6d1d3d8d13e4f3f4f9f12f15f17g2g5g8g17h6h16i14i18l1l7m12m14n16n18o2o10o12p7p8q13q15q17r3r7s10
  a10a18b4b7b16c6c11d13d17e14e19f9f14h7h9h10i3i6j12k1k7k10k19l1l3l12m8m15n4n14o7o10o17p8p16q7q10q18r1r8r11r13r15s2s14,a2a4a9a12a13a19b12d5d15e1e13e15f1f10g9g12h3h4h6i2i12i19j3j11j19l2l7l10l14l19m3m14n3n5n11o5o9o18o19p18q4q11r2r17r19
  a6b19c12c13c17e3e15e17e18f9f10f17g16g17h4h7h13h17i8i10i11i13i14i19j2j5j8k16l18m10n7n8n11n18o2o7o8o12p1p6p7p9p15p18p19r1r15r18s1s6s14s16,a4b6b9b13c5c9d1d5d14e8e10e16f1f6f12f18g3g14h1h3h8h15i2i3j6j10j17k8l4l8l9l11m7m11m17m18n10n12n14n15o1o9o17p2q12r2r4r8r14s12s15s17
  a12b4b11b13b17c2c3c4d11d18d19e13e18e19f11f13f17g2g4h1i9i11j3j4j11j17k3k10k13l7l10l14m1m2m5m12m18n10n12o2o5o7o14p2p13p16p18p19q16q18r5r6r19s12s18,a2b2b6b9c8c9c12c17d5d17e4e10e15e16f7f12f15f19g8g9h4h9h11h18i1i13i16i17i18j7k1k19l1l12m11n5n17o9o12p1p5p7p9p12p17q3q5q7q19r1s4s5s6s7s19
  a10a11a16b1b2b4b14c5c6c9c17d2d11d18d19e11e15f2f6f16g4g5g14h4h10h12i5i15i18j7j11j15j16k3k8k9k18l13l14l16l18m3m4m12m18n7n11n15o5o9p1p4p16q5q6q8q9q17r15r17s3s6,a1a3a7a9b3b8b11b18d1d5d6d14e13e19f4f5f12f13g1g2g9g13g15h6h8h11h13h14i3i14i17k2k7k16k17l6m2m10n2n4n12n14n18o2o15p3p13p14p15p18q3q13q14r1s1s5s7s10s11s16s18s19
  a2a3a14b15b18c1c10c14c16c17d8d12d19e1e2e4e5e8e9e11e13f4f19g5h4h15h17i19j2j9j12j16j18k2k5k8l7l10l17m13n7n9n10n15o1o6o9o10p3p14p16q10q11q12q16q17q18q19r7r10s3s5s11s14s16,a4a10a11a12b1b2b11b13c4c11c13d3d4d5d9d11e6e10e15e19f10f12g1g8g12g19h6h19i2i3j7j19k1k16k18l11l12l13l14m1m14n1n2n13o8o12o15p2p4p5p7p8p15p17q1q6q8r3r4r6r11r12r18s15s19
  a4a10b2b16c3c13d9d10d14d16d17e3e10e11e16f1f5f7f8f10f18g7g17h3h5h8i1i5i7i14i18j3j13j17k10k15k17l1l5l6l9l11l14l15m3m4m15m19n3n15o5o8o11o12o13o17p4p6p16q2q5q6q8q11q13q15r5r7r15s5s14s15,a6a15a17b1b6b7b8b14b18b19c2c8c9c14c16e5e15f2f17g1g8g14g15g19h9h14h19i4i6i8i11i13j2j6j14j15j16j18k9k14l8l12l13m5m7m8m12m13m17m18n2n4o15o18p2p8p18q16q17q19r2r3r8r10r11r13r16r17s1s8s13s19
  a13a14a18b1b2b3b11b18b19c1c3c5c11d2d4d12d18e3e5e7e8e10f3f7g6g18h1h3h7h11h14h15h19i1i2i8i9i10j9j10j17k7k15l6l8l10l12m5m6m7m12m17n2n4n5o2o18p2p7p8p10p14q2q4q7q14q16r2r5r19s1s2s9s12s17s19,a1a5a6a8b8c15c17d6d11d13d15d17e9e11e12e15e17f1f6f9f11f16f18g2g5g7g13g15g19h2h10h12i7i15j2j4j5k5k9k10k11k13k14k18l2l19m1m4m11m13m16n12n17n18o4o15o17p6p9p11p12p17q13q15q17q18r3r4r6r9r10s4s7s10s11s14
  a10a11a12a14a17b4b6b9c13c15c16d5d9d11d19e5e6e7e16f3f6g1g5g13g16g18h2h4h8h17h18h19i2i3i4i9i10i14i19j1j6j7j13j18j19k8l3l7l10m3m6m18n8n10n11n16o1o7o12o13o14o17o19p6p9p10p17q1q11q18r7r10r12r15r18s3s4s9s11,a2a6a16b1b2b15b18b19c3c7c8c18c19d2d3d7d8e2e3e4e13e18f9f11g3g4g10g14g15g17g19h9h12h15i6i8i16i17j3j4j5j11j12k1k2k11k12k15k16l1l2l6l16l19m1m14n2n6n14n15n18o2o6o10o11p19q2q3q4q6q8q17r2s6s7s12s13s15s18
  a3a5a9a11b2b3b4b5b6b9b19c5c11c14c16c18d5d6d11d19e5e7e12e15f4f8f11g5g14g19h2h3h5h10h16h17h19i17i18j1j4j5j6j9j12k7k15k17k19l1l5l16l17m1m2m11n6n8n12n14n18o1o11o12o16p1p12p14p15p16p18q2q12q13q14q18r5r10r13r14r15r16s13,a1a4a6a10a13a17a19b15b18c1c2c4c6c17d10d16e3e4e10e19f5f9f10f13f14f17f19g10g16h9h12i1i2i5i11i13i15i19j2j15j17k2k6k9k12k13k18l2l6l9l12l19m5m6m14m17n2n3n4n5n9n10n11o2o5o7o15o17p8p9p11p19q5q6q8q9q15r4r9s5s9s12s14
  b1c1b4c4,a2a3d2d3
)

def tag(key, body = "", **attrs)
  <<~STR
  <#{key} #{attrs.map {|k, v| "#{k}=#{v.to_s.dump}"}.join(" ")}>
    #{block_given? ? yield : body}
  </#{key}>
  STR
end

def draw_base
  svg = tag(:svg, xmlns: "http://www.w3.org/2000/svg", width: BOARD_SIZE + PADDING, height: BOARD_SIZE + PADDING, viewBox: "-#{PADDING} -#{PADDING} #{BOARD_SIZE + PADDING * 2} #{BOARD_SIZE + PADDING*2}") do
    outputs = []

    MAX_WIDTH.times do |i|
      diff = BOARD_SIZE / (MAX_WIDTH - 1).to_f
      x = y = diff * i

      outputs << tag(:text, (?a.ord + i).chr, x: x, y: - PADDING / 2, 'text-anchor': "middle", 'dominant-baseline': "central")
      outputs << tag(:text, i + 1, x: - PADDING / 2, y: y, 'text-anchor': "middle", 'dominant-baseline': "central")
      outputs << draw_path(0, y, BOARD_SIZE, y)
      outputs << draw_path(x, 0, x, BOARD_SIZE)
    end

    yield(outputs)

    outputs.join("\n")
  end

  "data:image/svg+xml;base64,#{Base64.encode64(svg).gsub(/\n/,"")}"
end

def draw_path(x1, y1, x2, y2)
  tag(:path, stroke: "black", d: "M#{x1},#{y1}L#{x2},#{y2}")
end

def draw_item(x, y, color)
  diff = BOARD_SIZE / (MAX_WIDTH - 1).to_f

  draw_circle(x * diff, y * diff, color, "#{x}, #{y}")
end

def draw_circle(x, y, color, memo)
  tag(:circle, cx: x, cy: y, r: 5, stroke: :black, fill: color) + "\n <!-- #{memo} -->"
end

def draw_area(x, y, color)
  diff = BOARD_SIZE / (MAX_WIDTH - 1).to_f

  tag(:rect, x: x * diff, y: y * diff, width: diff, height: diff, fill: color, 'fill-opacity' => 0.95)
end

def draw(input)
  w, b = parse(input)

  width  = [w.max_by(&:first).max || 0, b.max_by(&:first).max || 0].max + 1
  height = [w.max_by(&:last).max || 0, b.max_by(&:last).max || 0].max + 1
  board = Board.new(width, height)

  w.each do |x, y|
    board[y][x] = Cell.new(?w, x, y)
  end if w.flatten.any?

  b.each do |x, y|
    board[y][x] = Cell.new(?b, x, y)
  end if b.flatten.any?

  draw_base do |outputs|
    w.each do |x, y|
      outputs << draw_item(x, y, :white)
    end
    b.each do |x, y|
      outputs << draw_item(x, y, :black)
    end

    board.marked_board('w').each.with_index do |row, y|
      row.each.with_index do |c, x|
        next unless c

        outputs << draw_area(x, y, :white)
      end
    end

    board.marked_board('b').each.with_index do |row, y|
      row.each.with_index do |c, x|
        next unless c

        outputs << draw_area(x, y, :black)
      end
    end
  end
end

out = Pathname.new(__dir__).join("..", "..", "source",  "2016-10-01-doukaku-e08", "doukaku.json")
FileUtils.mkdir_p(out.dirname)
out.write(
  JSON.pretty_generate(
    data.map {|input|
      {input: input, expected: solve(input), image: draw(input)}
    }
  )
)
