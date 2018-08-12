require 'rails_helper'

RSpec.describe Cran::Parser do
  let(:packages) { File.open(Rails.root.join('spec', 'fixtures', 'PACKAGES.txt')).read }
  let(:parsed_packages) { Cran::Parser.parse(packages) }

  context 'PACKAGES' do
    it 'parses R packages file' do
      expect(parsed_packages.count).to eq(7)
    end

    it 'parsse package into a Hash' do
      pkg = parsed_packages.first

      expect(pkg[:package]).to eq('A3')
      expect(pkg[:version]).to eq('1.0.0')
      expect(pkg[:depends]).to eq('R (>= 2.15.0), xtable, pbapply')
      expect(pkg[:suggests]).to eq('randomForest, e1071')
      expect(pkg[:license]).to eq('GPL (>= 2)')
      expect(pkg[:needs_compilation]).to eq('no')
    end

    it 'parses packagea with multiple line values' do
      pkg = parsed_packages.select { |p| p[:package] == 'zooaRchGUI' }.first

      expect(pkg[:imports]).to eq('car, coda, foreign, geomorph, ggplot2,'\
        ' graphics, grDevices, MASS, pgirmess, raster, readxl, rjags, sp,'\
        ' spdep, splancs, stats, tcltk, tcltk2, tkrplot, utils, vegan')
    end
  end

  context 'RCF822' do
    it 'parses name and email' do
      parser = Cran::Parser.new('Author: Max Mustermann <max@example.com>').parse
      author = parser.first[:author].first

      expect(author[:name]).to eq('Max Mustermann')
      expect(author[:email]).to eq('max@example.com')
    end
  end
end
