Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6crUd4eod0LyUjuKqyiTTQ', 'wYBIy9xS5hLGiJJgsLAgU5ubvmn3JEP1uYDbiEV2g4'
  provider :facebook, '342224522576433', '77eb68dcd250da25174c98de993a545e'
  provider :linkedin, "cvochi9r9f9d", "GX7PA9XPcerMuio9", :scope => 'r_fullprofile r_emailaddress r_network' 
  provider :google_oauth2,"471674231335.apps.googleusercontent.com", "hFbhfSbHaBEjhPrbc5_RL5_L"
  end
