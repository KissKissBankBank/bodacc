require 'active_record'
require 'open-uri'
require 'mechanize'
require 'colorize'
require 'net/http'
require 'date'
require 'pg' # or 'mysql2' or 'sqlite3'

# Establishing connection
ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'mysql2' or 'sqlite3'
  database: 'bodacc',
  username: '',
  password: '',
  host:     'localhost'
)

# Models
class Bilan < ActiveRecord::Base
end
class Pcl < ActiveRecord::Base
end
class Immatriculation < ActiveRecord::Base
end
class Modification < ActiveRecord::Base
end
class Radiation < ActiveRecord::Base
end

# Accepted years
years =
[
  '2008',
  '2009',
  '2010',
  '2011',
  '2012',
  '2013',
  '2014',
  '2015',
  '2016',
  '2017'
]

# Every insertion are separated in their proper function, this one call them all
def insert_all
  insert_bilan
  insert_pcl
  insert_rcsA
  insert_rcsB
end

# # Function that rectify announcements that should be
# def rectify(type_bodacc, type_annonce, siren)
#   if type_annonce == 'rectificatif'
#     to_be_deleted = Bilan.where(siren: siren, type_annonce: 'annonce') if type_bodacc == 'Bilan'
#     to_be_deleted = Modification.where(siren: siren, type_annonce: 'annonce') if type_bodacc == 'Modification'
#     to_be_deleted = Radiation.where(siren: siren, type_annonce: 'annonce') if type_bodacc == 'Radiation'
#     to_be_deleted = Pcl.where(siren: siren, type_annonce: 'annonce') if type_bodacc == 'Pcl'
#     to_be_deleted = Immatriculation.where(siren: siren, type_annonce: 'annonce') if type_bodacc == 'Imatriculation'
#     if !to_be_deleted.nil?
#       puts to_be_deleted.inspect
#       to_be_deleted.delete_all
#       puts to_be_deleted.inspect
#       puts 'Announcements with siren ' + siren + ' has been deleted'
#     end
#   end
# end

# Insert every Bilan from "tmp/xml/BILAN" into database
def insert_bilan
  i = 0
  Dir.glob('tmp/xml/BILAN/*') do |file|
    xml = Nokogiri::XML(open(file))
    date = xml.xpath('//dateParution').first.text
    date = date.to_datetime
    xml.xpath('//avis').each do |avis|
      # rectify("Bilan", avis.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''), avis.search('numeroIdentificationRCS').text)
      Bilan.create( \
        nojo: avis.search('nojo').text,
        type_annonce: avis.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''),
        numero_annonce: avis.search('numeroAnnonce').text,
        numero_departement: avis.search('numeroDepartement').text,
        tribunal: avis.search('tribunal').text,
        siren: avis.search('numeroIdentificationRCS').text,
        code_rcs: avis.search('codeRCS').text,
        nom_greffe_immat: avis.search('nomGreffeImmat').text,
        denomination: avis.search('denomination').text,
        sigle: avis.search('sigle').text,
        forme_juridique: avis.search('formeJuridique').text,
        numero_voie: avis.search('numeroVoie').text,
        type_voie: avis.search('typeVoie').text,
        nom_voie: avis.search('nomVoie').text,
        compl_geographique: avis.search('complGeographique').text,
        code_postal: avis.search('codePostal').text,
        ville: avis.search('ville').text,
        date_cloture: avis.search('dateCloture').text,
        type_depot: avis.search('typeDepot').text,
        descriptif: avis.search('descriptif').text,
        nom_publication_ap: avis.search('parutionAvisPrecedent/nomPublication').text,
        numero_parution_ap: avis.search('parutionAvisPrecedent/numeroParution').text,
        date_parution_ap: avis.search('parutionAvisPrecedent/dateParution').text,
        numero_annonce_ap: avis.search('parutionAvisPrecedent/numeroAnnonce').text,
        file: file.split('/').last,
        type_bodacc: "BODACC C",
        annee_parution: date
      )
      i = i + 1
    end
    system("rm "+file)
    puts i.to_s + " announcements added from "+ file.split('/').last
    i = 0
    next if file == '.' or file == '..'
  end
end

# Insert every PCL from "tmp/xml/PCL" into database
def insert_pcl
  i = 0
  Dir.glob('tmp/xml/PCL/*') do |file|
    xml = Nokogiri::XML(open(file))
    date = xml.xpath('//dateParution').first.text
    date = date.to_datetime
    xml.xpath('//annonce').each do |annonce|
      # rectify("Pcl", annonce.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''), annonce.search('numeroIdentificationRCS').text)
      Pcl.create( \
        nojo: annonce.search('nojo').text,
        type_annonce: annonce.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''),
        numero_annonce: annonce.search('numeroAnnonce').text,
        numero_departement: annonce.search('numeroDepartement').text,
        tribunal: annonce.search('tribunal').text,
        identifiant_client: annonce.search('identifiantClient').text,
        siren: annonce.search('numeroIdentificationRCS').text,
        code_rcs: annonce.search('codeRCS').text,
        nom_greffe_immat: annonce.search('nomGreffeImmat').text,
        denomination: annonce.search('denomination').text,
        sigle: annonce.search('sigle').text,
        forme_juridique: annonce.search('formeJuridique').text,
        numero_voie: annonce.search('numeroVoie').text,
        type_voie: annonce.search('typeVoie').text,
        nom_voie: annonce.search('nomVoie').text,
        compl_geographique: annonce.search('complGeographique').text,
        code_postal: annonce.search('codePostal').text,
        ville: annonce.search('ville').text,
        famille: annonce.search('famille').text,
        nature: annonce.search('nature').text,
        date_jugement: annonce.search('date').text,
        compl_jugement: annonce.search('complementJugement').text,
        nom_publication_ap: annonce.search('parutionAvisPrecedent/nomPublication').text,
        numero_parution_ap: annonce.search('parutionAvisPrecedent/numeroPublication').text,
        date_parution_ap: annonce.search('parutionAvisPrecedent/dateParution').text,
        numero_annonce_ap: annonce.search('parutionAvisPrecedent/numeroAnnonce').text,
        file: file.split('/').last,
        type_bodacc: "BODACC A",
        annee_parution: date
      )
      i = i + 1
    end
    system("rm "+file)
    puts i.to_s + " announcements added from "+ file.split('/').last
    i = 0
    next if file == '.' or file == '..'
  end
end

# Insert every RCS-A from "tmp/xml/RCS-A" into database
def insert_rcsA
  i = 0
  Dir.glob('tmp/xml/RCS-A/*') do |file|
    xml = Nokogiri::XML(open(file))
    xml.xpath('//avis').each do |annonce|
      if !annonce.search('categorieVente').blank?
        immat = annonce.search('categorieVente').text
        categorie = "Vente"
      elsif !annonce.search('categorieCreation').blank?
        immat = annonce.search('categorieCreation').text
        categorie = "Creation"
      else
        immat = annonce.search('immatriculation').text
        categorie = "Immatriculation"
      end
      date = xml.xpath('//dateParution').first.text
      date = date.to_datetime
      # rectify("Immatriculation", annonce.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''), annonce.search('numeroIdentificationRCS').text)
        Immatriculation.create( \
          nojo: annonce.search('nojo').text,
          type_annonce: annonce.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''),
          numero_annonce: annonce.search('numeroAnnonce').text,
          numero_departement: annonce.search('numeroDepartement').text,
          tribunal: annonce.search('tribunal').text,
          siren: annonce.search('numeroIdentification').text,
          code_rcs: annonce.search('codeRCS').text,
          nom_greffe_immat: annonce.search('nomGreffeImmat').text,
          denomination: annonce.search('denomination').text,
          administration: annonce.search('administration').text,
          montant_capital: annonce.search('montantCapital').text,
          devise: annonce.search('devise').text,
          forme_juridique: annonce.search('formeJuridique').text,
          type_voie: annonce.search('typeVoie').text,
          numero_voie: annonce.search('numeroVoie').text,
          nom_voie: annonce.search('nomVoie').text,
          code_postal: annonce.search('codePostal').text,
          ville: annonce.search('ville').text,
          origine_fonds: annonce.search('origineFonds').text,
          qualite_etablissement: annonce.search('qualiteEtablissement').text,
          activite: annonce.search('activite').text,
          date_commencement_activite: annonce.search('dateCommencementActivite').text,
          date_immatriculation: annonce.search('dateImmatriculation').text,
          descriptif: annonce.search('descriptif').text,
          date_effet: annonce.search('dateEffet').text,
          journal: annonce.search('journal').text,
          opposition: annonce.search('opposition').text,
          declaration_creance: annonce.search('declarationCreance').text,
          categorie: categorie,
          immatriculation: immat,
          nom_publication_ap: annonce.search('parutionAvisPrecedent/nomPublication').text,
          numero_parution_ap: annonce.search('parutionAvisPrecedent/numeroPublication').text,
          date_parution_ap: annonce.search('parutionAvisPrecedent/dateParution').text,
          numero_annonce_ap: annonce.search('parutionAvisPrecedent/numeroAnnonce').text,
          file: file.split('/').last,
          type_bodacc: "BODACC A",
          annee_parution: date
        )
        i = i + 1
    end
    system("rm " +file)
    puts i.to_s + " announcements added from "+ file.split('/').last
    i = 0
    next if file == '.' or file == '..'
  end
end

# Insert every RCS-B from "tmp/xml/RCS-B" into database
def insert_rcsB
  i = 0
  Dir.glob('tmp/xml/RCS-B/*') do |file|
    xml = Nokogiri::XML(open(file))
    xml.xpath('//avis').each do |annonce|
      date = xml.xpath('//dateParution').first.text
      date = date.to_datetime
      if !annonce.search('modificationsGenerales').blank?
        # rectify("Modification", avis.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''), avis.search('numeroIdentificationRCS').text)
        Modification.create( \
          nojo: annonce.search('nojo').text,
          type_annonce: annonce.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''),
          numero_annonce: annonce.search('numeroAnnonce').text,
          numero_departement: annonce.search('numeroDepartement').text,
          tribunal: annonce.search('tribunal').text,
          siren: annonce.search('numeroIdentificationRCS').text,
          code_rcs: annonce.search('codeRCS').text,
          nom_greffe_immat: annonce.search('nomGreffeImmat').text,
          denomination: annonce.search('denomination').text,
          sigle: annonce.search('sigle').text,
          forme_juridique: annonce.search('formeJuridique').text,
          date_commencement_activite: annonce.search('dateCommencementActivite').text,
          date_effet: annonce.search('dateEffet').text,
          descriptif: annonce.search('descriptif').text,
          denomination_pepm: annonce.search('modificationsGenerales/precedentExploitantPM/denomination').text,
          siren_pepm: annonce.search('modificationsGenerales/precedentExploitantPM/numeroImmatriculation/numeroIdentification').text,
          nature_pepp: annonce.search('modificationsGenerales/precedentExploitantPP/nature').text,
          nom_pepp: annonce.search('modificationsGenerales/precedentExploitantPP/nom').text,
          prenom_pepp: annonce.search('modificationsGenerales/precedentExploitantPP/prenom').text,
          nom_usage_pepp: annonce.search('modificationsGenerales/precedentExploitantPP/nomUsage').text,
          siren_pepp: annonce.search('modificationsGenerales/precedentExploitantPP/numeroImmatriculation/numeroIdentification').text,
          nom_publication_ap: annonce.search('parutionAvisPrecedent/nomPublication').text,
          numero_parution_ap: annonce.search('parutionAvisPrecedent/numeroPublication').text,
          date_parution_ap: annonce.search('parutionAvisPrecedent/dateParution').text,
          numero_annonce_ap: annonce.search('parutionAvisPrecedent/numeroAnnonce').text,
          file: file.split('/').last,
          type_bodacc: "BODACC B",
          annee_parution: date
        )
      else
        # rectify("Radiation", avis.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''), avis.search('numeroIdentificationRCS').text)
        Radiation.create( \
          nojo: annonce.search('nojo').text,
          type_annonce: annonce.search('typeAnnonce').children.to_s.gsub(/[<>\/]/, ''),
          numero_annonce: annonce.search('numeroAnnonce').text,
          numero_departement: annonce.search('numeroDepartement').text,
          tribunal: annonce.search('tribunal').text,
          siren: annonce.search('numeroIdentificationRCS').text,
          code_rcs: annonce.search('codeRCS').text,
          nom_greffe_immat: annonce.search('nomGreffeImmat').text,
          denomination: annonce.search('denomination').text,
          sigle: annonce.search('sigle').text,
          forme_juridique: annonce.search('formeJuridique').text,
          type_voie: annonce.search('typeVoie').text,
          numero_voie: annonce.search('numeroVoie').text,
          nom_voie: annonce.search('nomVoie').text,
          code_postal: annonce.search('codePostal').text,
          ville: annonce.search('ville').text,
          radiation_pm: annonce.search('radiationPM').text,
          date_cessation_activite_pp: annonce.search('dateCessationActivitePP').text,
          commentaire: annonce.search('commentaire').text,
          nom_publication_ap: annonce.search('parutionAvisPrecedent/nomPublication').text,
          numero_parution_ap: annonce.search('parutionAvisPrecedent/numeroPublication').text,
          date_parution_ap: annonce.search('parutionAvisPrecedent/dateParution').text,
          numero_annonce_ap: annonce.search('parutionAvisPrecedent/numeroAnnonce').text,
          file: file.split('/').last,
          type_bodacc: "BODACC B",
          annee_parution: date
        )
      end
      i = i + 1
    end
    system("rm "+file)
    puts i.to_s + " announcements added from "+ file.split('/').last
    i = 0
    next if file == '.' or file == '..'
  end
end

# Return the correct path depending on the file type (ex: BILAN_BXC20080050.xml go to "tmp/xml/BILAN/BILAN_BXC20080050.xml")
def get_path(file)
  if file.to_s.include? 'BILAN'
    path = "tmp/xml/BILAN/" + file
  elsif file.to_s.include? 'RCS-A'
    path = "tmp/xml/RCS-A/" + file
  elsif file.to_s.include? 'RCS-B'
    path = "tmp/xml/RCS-B/" + file
  elsif file.to_s.include? 'PCL'
    path = "tmp/xml/PCL/" + file
  end
  return path
end

# Return the correct path depending on the file type (ex: BILAN_BXC20080050.xml go to "tmp/xml/BILAN/")
def get_path_archives(file)
  if file.to_s.include? 'BILAN'
    path = "tmp/xml/BILAN/"
  elsif file.to_s.include? 'RCS-A'
    path = "tmp/xml/RCS-A/"
  elsif file.to_s.include? 'RCS-B'
    path = "tmp/xml/RCS-B/"
  elsif file.to_s.include? 'PCL'
    path = "tmp/xml/PCL/"
  end
  return path
end

# Url
url = "https://echanges.dila.gouv.fr/OPENDATA/BODACC/#{Time.now.year}/"
url_archives = "https://echanges.dila.gouv.fr/OPENDATA/BODACC/FluxHistorique/"

agent = Mechanize.new # For Download

# If we don't already have the past years Bodacc anouncements we download all of them
if Bilan.count == 0

  # Let's scrap this page with Nokogiri and Mechanize
  page = Nokogiri::HTML(open(url_archives)) # For Scrap

  puts "Downloading historical files...".light_blue

  # Iterate on every <tr> of the table that contain every files
  page.search('//tr').each do |line|
    next if line.search('td/text()')[4].to_s.blank?
    file = line.search('td > a/text()').to_s.strip

    # If you only want to insert a special year (ex: only 2015)
    if ARGV[0]
      next if !file.include? ARGV[0] and years.include? ARGV[0]
    end

    # Init path for archives
    path = "tmp/archives/"

    # Gonna catch them all !
    puts "Downloading announcements of " + file.gsub(/[^0-9]/, '') + " year"
    agent.pluggable_parser.default = Mechanize::Download
    agent.get(url_archives + file).save(path + file)

    # Untar the big folder containing compressed files (ex: BODACC_2008.tar)
    puts "Decompressing entire folder of " + file.gsub(/[^0-9]/, '') + " year"
    system('tar -xf '+path + file+ ' -C '+path+'')

    # Untar every files and move them in their correct folder (ex: RCS-A_BXA20080144.taz)
    Dir.glob('tmp/archives/**/**/*.taz*') do |file|
      if file.split('/').last.include? "_"
        system('tar -xf '+file+' -C '+get_path_archives(file)+'')
      end
    end

    # Destroy every useless folders
    system('rm -rf tmp/archives/*')

    # Files are now in xml format, ready to be send in database
    # Insert announcements in database. All in private functions down here
    puts "Inserting in database...".light_blue
    insert_all
  end
end

puts "Historical announcements finished".light_blue
puts "Starting to scrap actual year announcements...".light_blue

# Nokogiri for xml scraping, Mechanize for file download
page = Nokogiri::HTML(open(url))

# Download every new files
puts "Downloading and decompresing files...".light_blue
page.search('//tr').each do |line|
  next if line.search('td/text()')[4].to_s.blank?
  date = line.search('td/text()')[4].to_s.strip
  file = line.search('td > a/text()').to_s.strip

  # Init path depending on the file
  path = get_path(file)

  # Downloading them if not already
  if date.to_datetime > Bilan.order('annee_parution DESC').first.annee_parution
    agent.pluggable_parser.default = Mechanize::Download
    agent.get(url + file).save(path)

    # Untar every files and remove all .taz file
    system('tar -xf '+path+ ' -C '+path.gsub(file, "")+ '; rm '+path)

    # Files are now in xml format, ready to be send in database
    # Insert announcements in database. All in private functions down here
    puts "Inserting in database...".light_blue
    insert_all
    # system('rm tmp/xml/BILAN/* tmp/xml/BILAN/* tmp/xml/BILAN/* tmp/xml/BILAN/*')
  end
end

# Boaper did his Job, wish him a good day
puts "Bodacc did his job !".green
puts "Bye !"
