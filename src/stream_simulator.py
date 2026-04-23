def data_stream(file_path):
    import csv

    with open(file_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)

        for row in reader:
            y = int(row.pop('label'))

            # Colonnes à retirer pour éviter la fuite d'information
            row.pop('attack_cat', None)
            row.pop('id', None)

            # Conversion des nombres
            for k, v in row.items():
                try:
                    row[k] = float(v)
                except:
                    pass

            yield row, y