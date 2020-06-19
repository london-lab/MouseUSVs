function new_centroids = update_centroids(centroids, centroid_update, update_value)
    new_centroids = centroids;
    new_centroids(centroid_update, :) = update_value.*new_centroids(centroid_update, :);
end