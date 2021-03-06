# This is a modified version of the code found in https://github.com/bpaquet/pcap_tools/blob/master/lib/pcap_tools/packet_processors/tcp.rb.

require 'time'

module QReplay

  class TcpProcessor

    def initialize
      @streams = {}
      @stream_processors = []
    end

    def add_stream_processor processor
      @stream_processors << processor
    end

    def inject index, packet
      stream_index = packet[:stream]
      if stream_index
        if packet[:tcp_flags][:syn] && packet[:tcp_flags][:ack] === false
          @streams[stream_index] = {
            :first => packet,
            :data => [],
          }
        elsif packet[:tcp_flags][:fin] || packet[:tcp_flags][:rst]
          if @streams[stream_index]
            current = {:index => stream_index, :data => @streams[stream_index][:data]}
            @stream_processors.each do |p|
              current = p.process_stream current
              break unless current
            end
            @streams.delete stream_index
          end
        else
          unless @streams[stream_index]
            @streams[stream_index] = {
              :first => packet,
              :data => [],
            }
          end

          packet[:type] = (packet[:from] == @streams[stream_index][:first][:from] && packet[:from_port] == @streams[stream_index][:first][:from_port]) ? :out : :in
          packet.delete :tcp_flags
          @streams[stream_index][:data] << packet if packet[:size] > 0
        end
      end
    end

    def finalize
      @streams.each do |k, stream|
        current = {:index => k, :data => stream[:data]}
        @stream_processors.each do |p|
          current = p.process_stream current
          break unless current
        end
      end

      @stream_processors.each do |p|
        p.finalize
      end
    end

  end

end


