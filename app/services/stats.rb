class Stats
	def self.processing(id)
		workers.map {|name, work| work["payload"]["args"][0]}.include?(id)
	end

	def self.workers
    Sidekiq.redis do |conn|
      conn.smembers('workers').map do |w|
        msg = conn.get("worker:#{w}")
        msg ? [w, Sidekiq.load_json(msg)] : nil
      end.compact.sort { |x| x[1] ? -1 : 1 }
    end
	end
end