Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6crUd4eod0LyUjuKqyiTTQ', 'wYBIy9xS5hLGiJJgsLAgU5ubvmn3JEP1uYDbiEV2g4'
  provider :facebook, '342224522576433', '77eb68dcd250da25174c98de993a545e'
end