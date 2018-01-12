module Scrapper
  class ModificationAction
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/LineLength
    # rubocop:disable Metrics/AbcSize
    def self.create(annonce, file, date)
      Modification.create( \
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
        date_commencement_activite:
          annonce.search('dateCommencementActivite').text,
        date_effet:
          annonce.search('dateEffet').text,
        descriptif:
          annonce.search('descriptif').text,
        denomination_pepm:
          annonce.search('modificationsGenerales/precedentExploitantPM/denomination').text,
        siren_pepm:
          annonce.search('modificationsGenerales/precedentExploitantPM/numeroImmatriculation/numeroIdentification').text,
        nature_pepp:
          annonce.search('modificationsGenerales/precedentExploitantPP/nature').text,
        nom_pepp:
          annonce.search('modificationsGenerales/precedentExploitantPP/nom').text,
        prenom_pepp:
          annonce.search('modificationsGenerales/precedentExploitantPP/prenom').text,
        nom_usage_pepp:
          annonce.search('modificationsGenerales/precedentExploitantPP/nomUsage').text,
        siren_pepp:
          annonce.search('modificationsGenerales/precedentExploitantPP/numeroImmatriculation/numeroIdentification').text,
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
          'BODACC B',
        annee_parution:
          date,
      )
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/LineLength
    # rubocop:enable Metrics/AbcSize
  end
end
