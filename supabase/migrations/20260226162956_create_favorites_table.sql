/*
  # Sistema de Favoritos

  1. Nova Tabela
    - `favorites`
      - `id` (uuid, primary key)
      - `user_id` (uuid, referência para auth.users)
      - `news_id` (text, ID da notícia favoritada)
      - `news_data` (jsonb, dados completos da notícia para offline)
      - `created_at` (timestamptz, quando foi favoritado)
  
  2. Segurança
    - RLS habilitado
    - Usuários podem apenas ver e gerenciar seus próprios favoritos
    - Políticas separadas para SELECT, INSERT, DELETE
*/

CREATE TABLE IF NOT EXISTS favorites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  news_id text NOT NULL,
  news_data jsonb NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, news_id)
);

ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own favorites"
  ON favorites FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can add favorites"
  ON favorites FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can remove favorites"
  ON favorites FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS idx_favorites_user_id ON favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_favorites_created_at ON favorites(created_at DESC);
