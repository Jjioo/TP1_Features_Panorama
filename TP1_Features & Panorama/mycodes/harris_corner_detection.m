% Load images
ship1 = imread('../images/ship1.jpg');
ship2 = imread('../images/ship2.jpg');

% Detect Harris corner features in ship1 and ship2
features_ship1 = detectHarrisFeatures(ship1);
features_ship2 = detectHarrisFeatures(ship2);

% Visualize detected features (optional)
figure;
imshow(ship1);
hold on;
plot(features_ship1);
title('Detected Harris Corner Features in Ship1');

figure;
imshow(ship2);
hold on;
plot(features_ship2);
title('Detected Harris Corner Features in Ship2');
