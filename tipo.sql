-- Estensione UUID
create extension if not exists "uuid-ossp";

-- TABella MENU
create table if not exists menu_items (
  id uuid primary key default uuid_generate_v4(),
  categoria text not null,
  nome text not null,
  descrizione text,
  prezzo numeric(6,2) not null,
  immagine_url text,
  disponibile boolean default true,
  created_at timestamptz default now()
);

-- TABELLA PRENOTAZIONI
create table if not exists prenotazioni (
  id uuid primary key default uuid_generate_v4(),
  nome text not null,
  telefono text not null,
  data date not null,
  ora text not null,
  persone integer not null,
  note text,
  stato text default 'nuova',
  created_at timestamptz default now()
);

-- TABELLA ORDINI
create table if not exists ordini (
  id uuid primary key default uuid_generate_v4(),
  nome text not null,
  telefono text not null,
  adulti integer not null default 1,
  bambini integer not null default 0,
  modalita text default 'asporto',
  data_consegna date,
  ora_consegna text,
  compleanno boolean default false,
  compleanno_note text,
  allergie text[] default '{}',
  allergie_note text,
  totale numeric(8,2) default 0,
  stato text default 'nuovo',
  created_at timestamptz default now()
);

-- TABELLA DETTAGLIO ORDINI
create table if not exists ordine_items (
  id uuid primary key default uuid_generate_v4(),
  ordine_id uuid references ordini(id) on delete cascade,
  nome_piatto text not null,
  quantita integer not null default 1,
  prezzo_unitario numeric(6,2) not null,
  created_at timestamptz default now()
);

-- SICUREZZA (RLS)
alter table menu_items enable row level security;
alter table prenotazioni enable row level security;
alter table ordini enable row level security;
alter table ordine_items enable row level security;

create policy "menu pubblico" on menu_items for select using (true);
create policy "insert prenotazioni" on prenotazioni for insert with check (true);
create policy "insert ordini" on ordini for insert with check (true);
create policy "insert ordine items" on ordine_items for insert with check (true);

-- DATI INIZIALI MENU
insert into menu_items (categoria, nome, descrizione, prezzo, immagine_url) values
('pizzeria','Margherita','Pomodoro San Marzano, mozzarella, basilico, olio EVO',6.50,'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80'),
('pizzeria','Marinara','Pomodoro San Marzano, aglio, origano, olio extravergine',5.50,'https://images.unsplash.com/photo-1595708684082-a173bb3a06c5?w=400&q=80'),
('pizzeria','Diavola','Pomodoro, mozzarella, salame piccante, peperoncino',8.00,'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&q=80'),
('pizzeria','Prosciutto e Funghi','Pomodoro, mozzarella, prosciutto cotto, funghi',8.50,'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80'),
('pizzeria','Quattro Stagioni','Pomodoro, mozzarella, prosciutto, funghi, carciofi, olive',9.50,'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?w=400&q=80'),
('pizzeria','Bufala DOP','Pomodoro San Marzano, mozzarella di bufala DOP, basilico',10.00,'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&q=80'),
('pizzeria','Tartufo Nero','Mozzarella, crema tartufo nero, funghi porcini, parmigiano',12.00,'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=400&q=80'),
('pizzeria','Nduja Calabrese','Pomodoro, mozzarella, nduja piccante, stracciatella',9.50,'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&q=80'),
('primi','Spaghetti Carbonara','Guanciale, pecorino romano, uova, pepe nero',12.00,'https://images.unsplash.com/photo-1609956428152-270669ca3620?w=400&q=80'),
('primi','Penne all''Arrabbiata','Pomodoro San Marzano, aglio, peperoncino fresco',10.00,'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=400&q=80'),
('primi','Tagliatelle al Ragù','Pasta fresca, ragù di carne cotto 6 ore, parmigiano',13.00,'https://images.unsplash.com/photo-1556760544-74068565f05c?w=400&q=80'),
('primi','Risotto ai Funghi Porcini','Riso Carnaroli, funghi porcini freschi, burro, parmigiano',14.00,'https://images.unsplash.com/photo-1476124369969-9f1a9e003390?w=400&q=80'),
('primi','Linguine allo Scoglio','Frutti di mare freschi, pomodorini, aglio, prezzemolo',16.00,'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&q=80'),
('primi','Lasagna della Casa','Pasta fresca, ragù, besciamella, parmigiano',12.50,'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?w=400&q=80'),
('secondi','Tagliata di Manzo','Fesa di manzo alla griglia, rucola, parmigiano',18.00,'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=400&q=80'),
('secondi','Pollo alla Cacciatora','Pollo ruspante, pomodoro, olive, capperi, rosmarino',14.00,'https://images.unsplash.com/photo-1600891964599-f61ba0e23602?w=400&q=80'),
('secondi','Branzino al Forno','Branzino fresco, patate, pomodorini, olive, origano',19.00,'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400&q=80'),
('secondi','Cotoletta alla Milanese','Costoletta di vitello impanata, patate o insalata',16.00,'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400&q=80'),
('secondi','Salmone alla Griglia','Trancio di salmone fresco, verdure grigliate, limone',16.50,'https://images.unsplash.com/photo-1546241072-440ffea5729b?w=400&q=80'),
('dolci','Tiramisù della Casa','Mascarpone, savoiardi, caffè espresso, cacao',5.00,'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400&q=80'),
('dolci','Panna Cotta','Panna cotta alla vaniglia, frutti di bosco',4.50,'https://images.unsplash.com/photo-1533134242443-d4fd2353c44e?w=400&q=80'),
('dolci','Cannoli Siciliani','Ricotta fresca, gocce di cioccolato, pistacchio',4.00,'https://images.unsplash.com/photo-1563729784474-37dbd5dc15b7?w=400&q=80'),
('dolci','Cheesecake ai Frutti Rossi','Crema di formaggio, frutti di bosco freschi',5.50,'https://images.unsplash.com/photo-1533134242443-d4fd2353c44e?w=400&q=80'),
('dolci','Birra Artigianale','Selezione birre italiane (0.33L / 0.5L)',5.00,'https://images.unsplash.com/photo-1535958636474-b021ee887b13?w=400&q=80'),
('dolci','Vino della Casa','Rosso o bianco, sfuso o bottiglia',12.00,'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=400&q=80');