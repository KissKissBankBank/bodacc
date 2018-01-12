module Scrapper
  class PclAction
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def self.create(annonce, file, date)
      Pcl.create( \
        nojo:
          annonce.search('nojo').text,
        type_annonce:
          annonce.search('typeAnnonce').children.to_s.gsub(%r{<>/}, ''),
        numero_annonce:
          annonce.search('numeroAnnonce').text,
        numero_departement:
          annonce.search('numeroDepartement').text,
        tribunal:
          annonce.search('tribunal').text,
        identifiant_client:
          annonce.search('identifiantClient').text,
        siren:
          annonce.search('numeroIdentificationRCS').text,
        code_rcs:
          annonce.search('codeRCS').text,
        nom_greffe_immat:
          annonce.search('nomGreffeImmat').text,
        denomination:
          annonce.search('denomination').text,
        sigle:
          annonce.search('sigle').text,
        forme_juridique:
          annonce.search('formeJuridique').text,
        numero_voie:
          annonce.search('numeroVoie').text,
        type_voie:
          annonce.search('typeVoie').text,
        nom_voie:
          annonce.search('nomVoie').text,
        compl_geographique:
          annonce.search('complGeographique').text,
        code_postal:
          annonce.search('codePostal').text,
        ville:
          annonce.search('ville').text,
        famille:
          annonce.search('famille').text,
        nature:
          annonce.search('nature').text,
        date_jugement:
          annonce.search('date').text,
        compl_jugement:
          annonce.search('complementJugement').text,
        nom_publication_ap:
          annonce.search('parutionAvisPrecedent/nomPublication').text,
        numero_parution_ap:
          annonce.search('parutionAvisPrecedent/numeroPublication').text,
        date_parution_ap:
          annonce.search('parutionAvisPrecedent/dateParution').text,
        numero_annonce_ap:
          annonce.search('parutionAvisPrecedent/numeroAnnonce').text,
        file:
          file.split('/').last,
        type_bodacc:
          'BODACC A',
        annee_parution:
          date,
      )
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
