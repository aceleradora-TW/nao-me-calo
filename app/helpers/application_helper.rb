module ApplicationHelper
  def calculate_average_establishment(establishment)
    all_ratings = establishment.ratings.map do |rating|
      rating.average_rating
    end

    all_ratings.delete_if {|x| x == nil}

    return (all_ratings.sum/all_ratings.length).round(1)
  end

  def populate_rate_array(ratings)
    rate_array = []
    ratings.each do |rating|
      if rating.average_rating < 1.8
        rate_array.push([rating,"Péssimo"])
      elsif rating.average_rating < 2.6
        rate_array.push([rating,"Ruim"])
      elsif rating.average_rating < 3.4
        rate_array.push([rating,"Regular"])
      elsif rating.average_rating < 4.2
        rate_array.push([rating,"Bom"])
      else
        rate_array.push([rating,"Ótimo"])
      end
    end

    return rate_array
  end


  def determine_concept(rating)
    case rating
    when 1 ... 1.8
      @rating_concept = "Péssimo"
    when 1.8 ... 2.6
      @rating_concept = "Ruim"
    when 2.6 ... 3.4
      @rating_concept = "Regular"
    when 3.4 ... 4.2
      @rating_concept = "Bom"
    else
      @rating_concept = "Ótimo"
    end
    return @rating_concept
  end

  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each {|type|
      if flash[type]
        messages += "#{flash[type]}"
      end
    }

    messages
  end

  def get_bad_word
    bad_words = ["babaca", "babacÊo", "babacaum", "babacas", "b a b a c a s", "b a b a c a", "b_a_b_a_c_a", "b_a_b_a_c_a_s", "bagos", "bago", "b a g o", "b a g o s", "b_a_g_o_s", "br‘_ulio", "br‘_ulho", "braulho", "barraco", "barracos", "bicha", "bixa", "bixinha", "bixona", "bixola", "bichola", "benga", "bichona", "b i x a", "b i c h a", "b_i_x_a", "b_i_c_h_a", "b i c h o n a", "b_i_c_h_o_n_a", "bimbada", "bimbadinha", "bimbadas", "boceta", "b o c e t a", "b_o_c_e_t_a", "b_o_c_e_t_a_s", "bo ce ta", "bocetas", "buceta", "bu ce ta", "bucetas", "b u c e t a s", "b u c e t a", "b_u_c_e_t_a", "b_u_c_e_t_a_s", "boga", "bogas", "boiola", "boiolas", "b o i o l a", "b o i o l a s", "b_o_i_o_l_a_s", "b_o_i_o_l_a", "b_o_l_a", "b_o_l_a_s", "b o l a s", "boquete", "boquetes", "boquetÍ_o", "boquetaum", "b o q u e t e", "b o q u e t e s", "b_o_q_u_e_t_e", "b_o_q_u_e_t_e_s", "boquetera", "boqueteira", "boquetero", "boqueteiro", "b o q u e t e i r a", "b o q u e t e i r o", "b o s t a", "b o s t a s", "b_o_s_t_a", "b_o_s_t_a_s", "brocha", "bronha", "bronhas", "b r o n h a s", "b r o n h a", "b_r_o_n_h_a", "b_r_o_n_h_a_s", "broxar", "broxas", "broxa", "broxar", "broxinha", "broxÍ_o", "brocha", "b r o x a", "b r o x a s", "b_r_o_x_a", "b_r_o_x_a_s", "b u n d a", "b u n d a s", "b_u_n_d_a", "b_u_n_d_a_s", "bundÍ_o", "bundaum", "caba_„o", "c a b a _„ o", "c_a_b_a__„_o", "ca ba _„o", "caba _„o", "ca ba_„o", "caba_„Í_o", "cabassÍ_o", "cabasso", "cabrÍ_o", "cabrona", "caceta", "c a c e t e", "cacete", "c a c e t e s", "cacetes", "c_a_c_e_t_e", "cacetÍ_o", "cacetinho", "cacetudo", "cacetuda", "cu de rola", "cafetÍ_o", "caguei", "c_a_g_a_r", "cagan_„a", "cagativo", "calhorda", "carcamano", "caralho", "cara_„as", "coraca", "casseta", "cassetudo", "cassetÍ_o", "cassetaum", "c h i f r e", "c_h_i_f_r_e", "chifrÍ_o", "choto", "chupisco", "chupisca", "c h u p a d a", "c h u p a d a s", "c_h_u_p_a_d_a", "chibil", "chibiu", "chibio", "chupa rola", "chuparola", "chupa_rola", "chupÍ_o", "chupaum", "chuparinho", "koko", "kok_„ñ", "cocozÍ_o", "coc_„ñ", "cocozÍ_o", "coiso", "coisar", "colhÍ_o", "colhudo", "colhÍ_es", "c o m e", "c o m e r", "cona", "c o r n o", "c_o_r_n_o_s", "cr‘_pula", "cricri", "cripentolha", "cus", "c u", "c_u", "c_u_s", "ku", "k_u", "k h no muro", "kh", "khr", "curra", "currar", "currada", "cuzÍ_o", "cuzao", "cuzaum", "c_u_z_Í__o", "c_u_z_a_o", "d a r", "d_a_r", "deflorar", "desflorar", "descaba_„ar", "descaba_„o", "desgra_„a", "enchedor de saco", "encrenca", "enrabar", "enrabada", "enrabado", "entesar", "escrota", "escroto", "e s c r o t o", "e_s_c_r_o_t_o", "escrotÍ_o", "escrotinho", "estuprador de", "estupradora", "estupro", "filha da puta", "filho_da_puta", "filhadaputa", "filho da puta", "filhodaputa", "filhodeumaputa", "filhadeumaputa", "filha de uma putanheiro", "filho de uma puta", "filho de um arronque", "filho de um marronque", "fiof‘¢", "fiofoh", "phiopho", "f i o f o", "fiofo", "fiof_„ñ", "fiofÍ_o", "fiofinho", "foda", "f o d a", "f_o_d_a", "fodÍ_o", "foda-se!", "fodedor", "fudedor", "fuck", "fodedor", "foder", "fuder", "f_u_d_e_r", "f o d e r", "f_o_d_e_r", "foder-se", "se foder", "se fuder", "fodido", "f r e s c o", "f_r_e_s_c_o", "frescÍ_o", "g_a_l_i_n_h_a", "g a l i n h a", "garanhÍ_o", "gilete", "gloques", "grelo", "jeba", "j e b a", "m a m i l o", "m_a_m_i_l_o", "mamilÍ_o", "mamilao", "mamilaum", "machÍ_o", "machona", "machorra", "maxorra", "maxoha", "m a c h o r r a", "machuda", "man_„_", "manezÍ_o", "manzapo", "mars‘_pio", "marmita", "marica", "mariquinha", "marikinha", "maricon", "m a r i c a", "m_a_r_i_c_a", "maricas", "m e r d a", "m_e_r_d_a", "merdinha", "merda", "merdoso", "mete", "m i j o", "m_i_j_o", "mijÍ_o", "mijentinho", "mijento", "minette", "nhanha", "obrar", "ovo", "o v o", "pajoÍ_o", "paijoÍ_o", "panasca", "panaca", "paquete", "p a u", "p_a_u", "pal", "p a l", "p_a_l", "pau-no-cu", "paunocu", "pau no cu", "pau_no_cu", "pau no ku", "pecunhaba", "ped_", "peitola", "p e i t o", "p e i t o s", "peitÍ_o", "pela saco", "pela_saco", "pelasaco", "peripat_„_tica", "peripat_„_tico", "pentelheira", "p e n t e l h o", "p_e_n_t_e_l_h_o", "peroba", "pica", "p i c a", "pi ca", "pika", "pik", "p i k", "pi k", "p ik", "p ica", "pic a", "p_ica", "pic_a", "p_i_c_a", "pi_„a", "p i _„ a", "p_i__„_a", "pi _„a", "pi_„a balÍ_o", "pissa", "picha", "piriquita", "piroca", "p i r o c a", "pirocÍ£o", "pirocaum", "pirocao", "p i r o c a", "pirocudo", "pirocuda", "pogobol mental", "porra", "porrinha", "porrÍ_o", "p o r r a", "p_o_r_r_a", "poha", "p o h a", "purra", "p_„ñrra", "pora", "porra louca", "priquita", "priquito", "punheta", "punhetinha", "punhetudo", "p u n h e t a", "p_u_n_h_e_t_a", "punheteira", "punheteiro", "puta", "p u t a", "p_u_t_a", "pu ta", "put a", "putinha", "putona", "puto", "putÍ£o", "putaum", "putao", "putamerda", "puta merda", "putanheiro", "puta que o pariu", "puta_que_pariu", "p_u_t_a_q_u_e_p_a_r_i_u", "puta_que_pariu", "puta_que_pario", "puta que pariu", "puta que pario", "puta que o pario", "putaquepariu", "putaquepario", "putaqueopariu", "putaqueopario", "puteiro", "p u t e i r o", "putzgrila", "putz grila", "puts grila", "putsgrila", "quenga", "kenga", "rabo", "rabeta", "r a b o", "r_a_b_o", "rameira", "rola", "r_„ñla", "r o l a", "rosca", "r_o_s_c_a", "rosca frouxa", "roscafrouxa", "roscafroucha", "rosca froxa", "rosca frocha", "rosca froucha", "rosca_froucha", "rosca_froxa", "rosca_frouxa", "rosqueirada", "saqueta", "sacanear", "sacote", "sacÍ£o", "sacudo", "saqueira", "s_a_c_o", "s a c o", "s a f a d o", "s a f a d a", "safadinha", "safadÍ£o", "safadinho", "sangalho", "sapatÍ£o", "sapatinha", "siririca", "s i r i r i c a", "s_i_r_i_r_i_c_a", "suruba", "sirigaita", "sexo", "s e x o", "secso", "sekso", "sesso", "secho", "cexo", "cecso", "s_e_x_o", "sexo selvagem", "tabacudo", "t a r a d o", "taradÍ_o", "taradinha", "taradinho", "tarraqueta", "tesÍ_o", "tta", "t t a", "t e t a", "t_e_t_a", "tetÍ_o", "toba", "tobaco", "t r a n s a r", "t r a n s a", "traveco", "transinha", "trepada", "trepadinha", "trepar", "tric_„ñ e croch_", "trottoir", "vaca", "v_a_g_i_n_a", "v a g i n a", "vaginÍ_o", "vagininha", "v_a_c_a", "vaivem", "vai vem", "veado", "viado", "v_e_a_d_o", "v_i_a_d_o", "xana", "x_a_n_a", "x a n a", "xaninha", "xanosa", "xavasca", "xereca", "xeca", "x e c a", "x_e_c_a", "xereca", "shereca", "chereca", "xerequinha", "xexeca", "xoxolteiro", "xota", "x o t a", "x_o_t_a", "xo ta", "xot a", "xoxota", "x o x o t a", "xoxotinha", "x o x o t i n h a", "xoxotona", "x o x o t o n a", "xoxoteira", "x o x o t e i r a", "xoxoteiro", "x o x o t e i r o", "a r a n h a", "traidora", "t r a i d o r a", "falsa", "inìtil", "idiota", "piranha", "p i r a n h a", "vagabunda", "v a g a b u n d a", "retardada", "r e t a r d a d a", "boticˆrio lixo", "traidora", "sapata", "s a p a t a", "sapatÜo", "preto sujo", "nego", "machorra", "m a c h o r r a", "machorrão", "m a c h o r r ã o", "bunda", "b u n d a", "fdp", "gordo", "gorda", "g o r d a", "g o r d o", "f d p", "pnc", "p n c", "feminazi"]
  end
end
