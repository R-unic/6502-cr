CYCLES = [
  # 00–0F
  7, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 4, 4, 6, 6,
  # 10–1F
  2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
  # 20–2F
  6, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 4, 4, 6, 6,
  # 30–3F
  2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
  # 40–4F
  6, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 3, 4, 6, 6,
  # 50–5F
  2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
  # 60–6F
  6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 5, 4, 6, 6,
  # 70–7F
  2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
  # 80–8F
  2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4,
  # 90–9F
  2, 6, 2, 6, 4, 4, 4, 4, 2, 5, 2, 5, 5, 5, 5, 5,
  # A0–AF
  2, 6, 2, 6, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
  # B0–BF
  2, 5, 2, 5, 4, 4, 6, 6, 2, 4, 2, 4, 4, 4, 7, 7,
  # C0–CF
  2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
  # D0–DF
  2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
  # E0–EF
  2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
  # F0–FF
  2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
] of UInt8

PAGE_CROSS = [
  # 00–0F
  false, false, false, false, false, false, false, false,
  false, false, false, false, false, false, false, false,
  # 10–1F
  false, true,  false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # 20–2F
  false, false, false, false, false, false, false, false,
  false, false, false, false, false, false, false, false,
  # 30–3F
  false, true,  false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # 40–4F
  false, false, false, false, false, false, false, false,
  false, false, false, false, false, false, false, false,
  # 50–5F
  false, true,  false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # 60–6F
  false, false, false, false, false, false, false, false,
  false, false, false, false, true,  false, false, false,
  # 70–7F
  false, true,  false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # 80–8F
  false, false, false, false, false, false, false, false,
  false, false, false, false, false, false, false, false,
  # 90–9F
  false, true,  false, false, false, false, false, false,
  false, true,  false, false, true,  true,  true,  true,
  # A0–AF
  false, false, false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # B0–BF
  false, true,  false, false, false, false, true,  true,
  false, true,  false, false, false, false, true,  true,
  # C0–CF
  false, false, false, false, false, false, false, false,
  false, false, false, false, false, false, false, false,
  # D0–DF
  false, true,  false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # E0–EF
  false, false, false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
  # F0–FF
  false, true,  false, false, false, false, true,  true,
  false, false, false, false, false, false, false, false,
] of Bool
