import xmltodict

fin = open('resources/map3.osm', 'r', encoding='utf8')
xml = fin.read()
fin.close()

parsedxml = xmltodict.parse(xml)

petrol_stations = 0

for node in parsedxml['osm']['node']:
    if 'tag' in node:
        if isinstance(node['tag'], list):
            for feature in node['tag']:
                if feature['@k'] == 'amenity':
                    if feature['@v'] == 'fuel':
                        petrol_stations += 1
        else:
            feature = node['tag']
            if feature['@k'] == 'amenity':
                if feature['@v'] == 'fuel':
                    petrol_stations += 1

for way in parsedxml['osm']['way']:
    if 'tag' in way:
        if isinstance(way['tag'], list):
            for feature in way['tag']:
                if feature['@k'] == 'amenity':
                    if feature['@v'] == 'fuel':
                        petrol_stations += 1
        else:
            feature = way['tag']
            if feature['@k'] == 'amenity':
                if feature['@v'] == 'fuel':
                    petrol_stations += 1

print(petrol_stations)


